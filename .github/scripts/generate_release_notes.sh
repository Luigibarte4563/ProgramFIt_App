#!/usr/bin/env bash
#
# generate_release_notes.sh
#
# Generates release documentation for ProgramFit:
#   1. A Keep-a-Changelog entry prepended to CHANGELOG.md
#   2. A full release note at docs/releases/v<version>.md
#
# Usage:
#   generate_release_notes.sh <tag> [previous_tag]
#
# Examples:
#   generate_release_notes.sh v1.0.0
#   generate_release_notes.sh v1.1.0 v1.0.0
#
# This script is used both by the GitHub Actions release workflow and can be
# run locally to preview generated notes.

set -euo pipefail

# --- Configuration -----------------------------------------------------------

REPO="Luigibarte4563/ProgramFIt_App"
DOCS_DIR="docs/releases"
CHANGELOG_FILE="CHANGELOG.md"

TAG_NAME="${1:?Usage: generate_release_notes.sh <tag> [previous_tag]}"
PREVIOUS_TAG="${2:-}"

# --- Validate the tag ---------------------------------------------------------

if ! git rev-parse "$TAG_NAME" >/dev/null 2>&1; then
  echo "::error::Git tag '$TAG_NAME' does not exist." >&2
  exit 1
fi

# Strip the leading "v" to get the semantic version, e.g. v1.0.0 -> 1.0.0.
VERSION="${TAG_NAME#v}"
if ! printf '%s' "$VERSION" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$'; then
  echo "::error::Tag '$TAG_NAME' is not a valid semantic version (expected vX.Y.Z)." >&2
  exit 1
fi

RELEASE_DATE="$(date -u +%Y-%m-%d)"

# --- Determine the commit range for this release ------------------------------

if [[ -z "$PREVIOUS_TAG" ]]; then
  # Auto-detect the nearest previous version tag (excluding the current one).
  PREVIOUS_TAG="$(git tag --sort=-v:refname | grep -v "^${TAG_NAME}$" | head -n 1 || true)"
fi

IS_FIRST_RELEASE=0
if [[ -n "$PREVIOUS_TAG" ]]; then
  RANGE="$PREVIOUS_TAG..$TAG_NAME"
else
  # First release: nothing before it, so count everything in the tagged tree.
  IS_FIRST_RELEASE=1
fi

echo "Generating release notes for $TAG_NAME (range: ${RANGE:-initial commit..$TAG_NAME})..."

if [[ "$IS_FIRST_RELEASE" -eq 1 ]]; then
  COMMITS="$(git log --pretty=format:'%s' "$TAG_NAME" 2>/dev/null || true)"
  FILE_COUNT="$(git ls-tree -r --name-only "$TAG_NAME" | sed '/^$/d' | wc -l | tr -d ' ')"
else
  COMMITS="$(git log --pretty=format:'%s' "$RANGE" 2>/dev/null || true)"
  FILE_COUNT="$(git diff --name-only "$RANGE" 2>/dev/null | sed '/^$/d' | wc -l | tr -d ' ')"
fi

COMMIT_COUNT="$(printf '%s\n' "$COMMITS" | sed '/^$/d' | wc -l | tr -d ' ')"

# --- Categorize commits by conventional-commit prefixes -----------------------

categorize() {
  local pattern="$1"
  printf '%s\n' "$COMMITS" \
    | grep -Ei "$pattern" \
    | sed -E 's/^[^:]+:[[:space:]]*//I' \
    | sed 's/[[:space:]]*$//' || true
}

FEATURES="$(categorize '^(feat|feature):')"
FIXES="$(categorize '^(fix|bugfix|bug|hotfix):')"
IMPROVEMENTS="$(categorize '^(improve|improvement|refactor|perf|chore|docs|style|test|build|ci):')"

COMMIT_COUNT="$(printf '%s\n' "$COMMITS" | sed '/^$/d' | wc -l | tr -d ' ')"

if [[ "$IS_FIRST_RELEASE" -eq 1 ]]; then
  OVERVIEW="ProgramFit is a career assessment system that helps students discover
university programs that align with their interests. This is the initial
release, containing **$COMMIT_COUNT** commits and **$FILE_COUNT** files."
else
  OVERVIEW="ProgramFit is a career assessment system that helps students discover
university programs that align with their interests. This release contains
**$COMMIT_COUNT** commits across **$FILE_COUNT** changed files compared with
the previous release ($PREVIOUS_TAG)."
fi

# --- Helper to render a markdown list (with a fallback for empty sections) ----

markdown_list() {
  local input="$1"
  local fallback="${2:-No notable changes.}"
  if [[ -z "$(printf '%s' "$input" | sed '/^$/d')" ]]; then
    echo "- ${fallback}"
    return
  fi
  printf '%s\n' "$input" | sed '/^$/d' | sed 's/^/- /'
}

# --- Build the release notes file ---------------------------------------------

RELEASE_NOTES="$DOCS_DIR/$TAG_NAME.md"
mkdir -p "$DOCS_DIR"

cat > "$RELEASE_NOTES" <<EOF
# Release $TAG_NAME

**Release date:** $RELEASE_DATE
**Tag:** \`$TAG_NAME\`

## Overview

$OVERVIEW

## ✨ New Features

$(markdown_list "$FEATURES" "No new features in this release.")

## 🚀 Improvements

$(markdown_list "$IMPROVEMENTS" "No improvements in this release.")

## 🐛 Bug Fixes

$(markdown_list "$FIXES" "No bug fixes in this release.")

## ⚠ Known Issues

- None reported for this release.

## 📥 Installation

1. Open the **[Latest Release](https://github.com/$REPO/releases/latest)** page.
2. Download **\`app-release.apk\`** from the **Assets** section.
3. If prompted, enable **Install unknown apps** on your Android device.
4. Install the APK and open the app.

For the web version or running from source, see the
[README](https://github.com/$REPO#readme).

## 🔄 Upgrade Notes

Install the new **\`app-release.apk\`** over the existing app. Your data is
preserved as long as the application ID remains the same.

## 👨‍💻 Developer Notes

- **Stack:** Flutter (Material 3), Dart, \`go_router\`, \`shared_preferences\`.
- **Build locally:**

  \`\`\`bash
  flutter build apk --release
  \`\`\`

  The APK is written to \`build/app/outputs/flutter-apk/app-release.apk\`.
- **Release automation:** created automatically by GitHub Actions when a
  version tag (\`v*\`) is pushed. See
  [\`.github/workflows/release.yml\`](https://github.com/$REPO/blob/main/.github/workflows/release.yml).
EOF

echo "Wrote $RELEASE_NOTES"

# --- Update CHANGELOG.md ------------------------------------------------------

# Keep-a-Changelog section for this version (only categories with content).
CHANGELOG_SECTION="## [$VERSION] - $RELEASE_DATE"
CHANGELOG_BODY=""
[[ -n "$(printf '%s' "$FEATURES" | sed '/^$/d')" ]] && CHANGELOG_BODY+=$'\n\n### Added\n\n'"$(markdown_list "$FEATURES")"
[[ -n "$(printf '%s' "$IMPROVEMENTS" | sed '/^$/d')" ]] && CHANGELOG_BODY+=$'\n\n### Changed\n\n'"$(markdown_list "$IMPROVEMENTS")"
[[ -n "$(printf '%s' "$FIXES" | sed '/^$/d')" ]] && CHANGELOG_BODY+=$'\n\n### Fixed\n\n'"$(markdown_list "$FIXES")"
# Fallback if no categorized commits matched.
[[ -z "$CHANGELOG_BODY" ]] && CHANGELOG_BODY=$'\n\n### Added\n\n- '"Release $TAG_NAME. See the release notes for details."

NEW_SECTION="${CHANGELOG_SECTION}${CHANGELOG_BODY}
"

if [[ -f "$CHANGELOG_FILE" ]]; then
  # Insert the new section after "## [Unreleased]" and refresh reference links.
  awk -v section="$NEW_SECTION" -v tag="$TAG_NAME" -v repo="$REPO" '
    /^## \[Unreleased\]$/ {
      print
      print ""
      print section
      inserted = 1
      next
    }
    /^\[Unreleased\]:/ {
      printf "[Unreleased]: https://github.com/%s/compare/%s...HEAD\n", repo, tag
      next
    }
    { print }
    END {
      if (!inserted) {
        print ""
        print section
      }
    }
  ' "$CHANGELOG_FILE" > "$CHANGELOG_FILE.tmp"
  mv "$CHANGELOG_FILE.tmp" "$CHANGELOG_FILE"

  # Append the version reference link if it is not already present.
  if ! grep -q "^\[$VERSION\]:" "$CHANGELOG_FILE"; then
    printf '[%s]: https://github.com/%s/releases/tag/%s\n' "$VERSION" "$REPO" "$TAG_NAME" >> "$CHANGELOG_FILE"
  fi
else
  # No changelog yet: create one with the standard header.
  cat > "$CHANGELOG_FILE" <<EOF
# Changelog

All notable changes to **ProgramFit** are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

$NEW_SECTION
[Unreleased]: https://github.com/$REPO/compare/$TAG_NAME...HEAD
[$VERSION]: https://github.com/$REPO/releases/tag/$TAG_NAME
EOF
fi

echo "Updated $CHANGELOG_FILE"
echo "Done."
