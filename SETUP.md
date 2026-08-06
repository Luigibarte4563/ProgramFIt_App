# ProgramFit — Setup Guide

This guide covers installing dependencies and running the **ProgramFit** Flutter app. It is an **offline MVP**: there is no backend, no accounts, and no configuration beyond the standard Flutter setup.

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.44.8 or compatible (includes Dart 3.12.2)
- For Android: Android Studio + Android SDK
- For iOS/macOS: Xcode (macOS only)
- For web: Chrome (recommended)

Verify the installation:

```bash
flutter --version
flutter doctor
```

## 1. Install dependencies

```bash
flutter pub get
```

That's it — no environment variables, API keys, or Firebase configuration are needed. The app runs fully offline and persists its data with `shared_preferences`.

## 2. Run the app

```bash
# Web
flutter run -d chrome

# Android (device or emulator connected)
flutter run -d <device-id>

# List available devices
flutter devices
```

The app launches directly into the home screen — no sign-in.

## 3. Build & release

```bash
# Web release build
flutter build web

# Android release build
flutter build apk --release
```

## 4. Testing & linting

```bash
# Run unit + widget tests
flutter test

# Analyze code for lint issues
flutter analyze
```

## Troubleshooting

- **`flutter run` can't find a device** → run `flutter doctor` and `flutter devices`.
- **Stale dependencies** → run `flutter pub get` and `flutter clean`.
