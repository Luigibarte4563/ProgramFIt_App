# ProgramFit

**ProgramFit** is a career assessment system that helps students discover university programs that align with their interests. It is a cross-platform Flutter application, migrated from the original React web app (`ProgramFit_Web`). It is an **offline MVP** — no accounts, no backend, no cloud services.

## Stack

| Layer      | Technology                                              |
|------------|----------------------------------------------------------|
| UI         | Flutter (Material 3) + custom neo-brutalist widgets      |
| Language   | Dart (SDK `^3.12.2`)                                     |
| State/routing | `go_router`                                           |
| Local storage | `shared_preferences` (offline persistence)           |
| Platforms  | Web, Android, iOS, Windows, macOS, Linux                 |
| Linting    | `flutter_lints`                                          |

## Features

- Launches directly into the app — no login, no accounts, no session management
- Two-phase interest assessment:
  - **Phase 1** — 7 general questions (8 lettered options) that tally points across 8 departments and rank them
  - **Phase 2** — 8 department-specific questions that rank that department's programs (or 8 Yes/Somewhat/No confirmation questions that measure fit for single-program departments like Nursing & Criminology)
- Top-3 program recommendations with flagship-program fallbacks and fit/confidence badges
- Progress + results persisted locally on the device (survives restarts)
- Neumorphism-style ("neo") UI theme and widgets
- Responsive layout with an app navigation bar

## Project Structure

```
lib/
├── main.dart                          # Entry point
├── app.dart                           # Root widget + GoRouter config
├── core/
│   ├── theme/
│   │   └── app_theme.dart             # Material 3 + neo theme
│   └── widgets/
│       ├── neo_badge.dart             # Neo-brutalist badge
│       ├── neo_button.dart            # Neo-brutalist button
│       └── neo_card.dart              # Neo-brutalist card
├── data/
│   ├── assessment_questions.dart      # Phase 1 / Phase 2 / confirmation questions
│   └── departments.dart               # 8 departments + 24 programs (flagships)
├── models/
│   ├── answer_option.dart             # Lettered option (maps to a target)
│   ├── assessment_outcome.dart        # Outcome, scores, Top-3 recommendations
│   ├── assessment_question.dart       # Question model
│   ├── confirmation_question.dart     # Confirmation question model
│   ├── department.dart                # Department model
│   └── program.dart                   # Program model
├── screens/
│   ├── home_screen.dart               # Home / landing
│   ├── assessment_screen.dart         # Two-phase assessment flow
│   ├── results_screen.dart            # Top-3 recommendations + breakdown
│   └── widgets/
│       ├── app_navbar.dart            # App navigation bar
│       ├── app_shell.dart             # Shell route (navbar + mobile menu)
│       ├── confirmation_card.dart     # Confirmation question card
│       ├── confirmation_scale.dart    # Yes / Somewhat / No scale
│       ├── neo_dialog.dart            # Neo-brutalist dialog
│       ├── option_scale.dart          # Lettered option list
│       ├── progress_bar.dart          # Assessment progress bar
│       ├── question_card.dart         # Question display card
│       └── result_card.dart           # Recommendation card
├── services/
│   └── assessment_service.dart        # Local progress persistence
└── utils/
    └── recommendation_engine.dart     # Tally / rank / Top-3 recommendation logic

test/
└── widget_test.dart                   # Unit + app-launch smoke tests

android/ ios/ linux/ macos/ web/ windows/   # Platform runners
```

## Getting Started

See **[SETUP.md](SETUP.md)** for full installation and running instructions.

### Requirements

- Flutter 3.44.8 (Dart 3.12.2) or compatible — install from [flutter.dev](https://docs.flutter.dev/get-started/install)

Verify your environment:

```bash
flutter --version
flutter doctor
```

---

## 🚀 How to Run

### 1. Get the dependencies

```bash
cd ProgramFit_Flutter
flutter pub get
```

### 2. Run on your computer (in Flutter)

```bash
# Web
flutter run -d chrome

# Or run in another installed browser (Edge, etc.)
flutter run -d edge
```

No configuration needed — the app launches straight into the home screen.

### 3. Run on your phone

#### Android

1. **Enable Developer Options & USB debugging** on your phone:
   - Settings → About phone → tap **Build number** 7 times.
   - Settings → Developer options → turn on **USB debugging**.

2. **Plug in your phone** via USB (and accept the "Allow USB debugging" prompt).

3. List your connected devices:

   ```bash
   flutter devices
   ```

   Your phone should show up. Then run:

   ```bash
   flutter run -d <device-id>
   ```

#### iOS (requires a Mac + Xcode)

```bash
flutter run -d <your-iphone-id>
```

#### No cable? Run wirelessly (Android)

```bash
flutter devices                       # note your phone's ID
adb tcpip 5555
adb connect <phone-ip>:5555
flutter run -d <device-id>
```

(Your phone and computer must be on the same Wi-Fi network.)

### 4. Build installable apps

```bash
# Android APK you can send to your phone
flutter build apk --release
# The APK is written to build/app/outputs/flutter-apk/app-release.apk

# Web build
flutter build web
```

### Useful commands

```bash
flutter devices    # list connected devices/emulators
flutter run        # run on the default connected device
flutter test       # run the widget/unit tests
flutter analyze    # check for lint issues
```

> **Tip:** If `flutter run` can't find your phone, run `flutter doctor` and make sure the Android toolchain is installed, then reconnect the USB cable and tap "Allow" on the phone.

---

## 📱 Install the App

The easiest way to use **ProgramFit** is to download the latest Android APK from the GitHub Releases page:

- **Repository:** <https://github.com/Luigibarte4563/ProgramFIt_App>
- **Latest Release:** <https://github.com/Luigibarte4563/ProgramFIt_App/releases/latest>
- **All Releases:** <https://github.com/Luigibarte4563/ProgramFIt_App/releases>

### Installation Steps

1. Open the **[Latest Release](https://github.com/Luigibarte4563/ProgramFIt_App/releases/latest)** page.
2. Download **`app-release.apk`** from the **Assets** section.
3. If prompted, enable **Install unknown apps** on your Android device.
4. Install the APK.
5. Open and enjoy the application.

### 🔄 Updating the App

Whenever a new version is released on GitHub, updating is simple:

1. Visit the **[Latest Release](https://github.com/Luigibarte4563/ProgramFIt_App/releases/latest)** page.
2. Download the newest **`app-release.apk`**.
3. Install it over the existing app.

Your data will be preserved as long as the application ID remains the same.

### 📦 Version History

Want an older build? Browse the **[Releases](https://github.com/Luigibarte4563/ProgramFIt_App/releases)** page to download any previous version.

- **[CHANGELOG.md](CHANGELOG.md)** — full change history, following [Keep a Changelog](https://keepachangelog.com/).
- **Release notes** — detailed notes per version, stored in [`docs/releases/`](docs/releases/).

| Version | Build | Release Notes |
|---------|-------|---------------|
| [1.0.0](https://github.com/Luigibarte4563/ProgramFIt_App/releases/tag/v1.0.0) | +1 | [Initial release](docs/releases/v1.0.0.md). Offline MVP: two-phase interest assessment, Top-3 program recommendations with fit badges, local progress persistence, and a neo-brutalist Material 3 UI across web, Android, and iOS. |

### 👨‍💻 For Developers

Releases are automatically generated using **GitHub Actions**. To cut a new release, tag the version and push it:

```bash
git add .
git commit -m "Release v1.0.0"
git push origin main

git tag v1.0.0
git push origin v1.0.0
```

The workflow automatically:

- Builds the Flutter release APK.
- Generates a **[CHANGELOG.md](CHANGELOG.md)** entry and release notes in **[`docs/releases/`](docs/releases/)**.
- Commits and pushes the generated documentation.
- Creates (or updates) a GitHub Release.
- Uploads **`app-release.apk`** as a Release Asset.
- Makes the APK available for download from the Releases page.
- Requires no manual APK upload.

For details, see [`.github/workflows/release.yml`](.github/workflows/release.yml).
