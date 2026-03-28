# T-POP Subscription App

Flutter application for the T-POP subscription flow. This project focuses on 3 main experiences:

- browsing subscription packages
- reviewing purchase history
- managing app settings such as language and app version

## Highlights

- Built with Flutter and GetX
- Uses Firebase Core and Cloud Firestore as the primary data source
- Supports English (`en_US`) and Thai (`th_TH`)
- Separates Firestore data by environment under `staging` and `prod`
- Seeds default subscription packages automatically when the package catalog is empty

## Tech Stack

- Flutter
- Dart SDK `^3.7.0`
- GetX
- Get Storage
- Firebase Core
- Cloud Firestore
- Google Fonts

## Project Structure

```text
lib/
|- app_environment.dart
|- firebase_options.dart
|- main.dart
|- modules/subscription/
|  |- data/
|  |- domain/
|  |- presentation/
|- routes/
|- service/
|- utils/
```

Key files:

- `lib/main.dart` initializes Firebase, local storage, theme, localization, and routes
- `lib/app_environment.dart` defines the active environment and app-level configuration
- `lib/modules/subscription/data/datasources/subscription_firestore_datasource.dart` handles package and purchase history reads/writes in Firestore
- `lib/modules/subscription/presentation/bindings/subscription_binding.dart` wires dependencies for the subscription module

## Requirements

- Flutter SDK compatible with Dart `3.7.x`
- Xcode for iOS builds or Android Studio / Android SDK for Android builds
- Firebase project configuration already generated in `lib/firebase_options.dart`

## Getting Started

Install dependencies:

```bash
flutter pub get
```

Run the app in the default staging environment:

```bash
flutter run --dart-define=APP_ENV=staging
```

Run the app in the production environment:

```bash
flutter run --dart-define=APP_ENV=prod
```

Optional API override:

```bash
flutter run --dart-define=APP_ENV=staging --dart-define=API_BASE_URL=https://staging-api.t-pop.app
```

## Firestore Layout

The app stores data under the selected environment branch:

```text
environments/{staging|prod}/subscription_packages
environments/{staging|prod}/subscription_purchases
```

Behavior:

- missing package documents are seeded from `subscription_seed_catalog.dart`
- purchasing a package expires any currently active purchase before inserting the new one
- clearing history deletes all purchase documents in the current environment

## Localization

Supported locales:

- English (`en_US`)
- Thai (`th_TH`)

Translations are defined in `lib/utils/lang/app_translations.dart`.

## Notes

- Firebase options are currently configured for Android and iOS
- Web, macOS, Windows, and Linux are not configured in `lib/firebase_options.dart`
- The initial route is `/subscription`
- There is currently no `test/` directory in this repository

## Useful Commands

```bash
flutter analyze
```
