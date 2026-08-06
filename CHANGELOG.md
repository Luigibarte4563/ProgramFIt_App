# Changelog

All notable changes to **ProgramFit** are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2026-08-06

### Added

- **Initial release.** Offline MVP of the career assessment system.
- **No-account launch** — app opens straight into the home screen; no login, accounts, or session management.
- **Two-phase interest assessment:**
  - Phase 1: 7 general questions with 8 lettered options that tally points across 8 departments and rank them.
  - Phase 2: 8 department-specific questions that rank that department's programs (or Yes/Somewhat/No confirmation questions for single-program departments like Nursing & Criminology).
- **Top-3 program recommendations** with flagship-program fallbacks and fit/confidence badges.
- **Local persistence** — progress and results survive app restarts (`shared_preferences`).
- **Neo-brutalist Material 3 UI** — custom theme and widgets (cards, buttons, badges, dialogs, progress bars).
- **Responsive layout** with an app navigation bar.
- Cross-platform runners for Web, Android, iOS, Windows, macOS, and Linux.

[Unreleased]: https://github.com/Luigibarte4563/ProgramFIt_App/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/Luigibarte4563/ProgramFIt_App/releases/tag/v1.0.0
