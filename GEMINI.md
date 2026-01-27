# Project Overview

**AMK Bank Project** is a mobile banking application built with **Flutter**. It follows a **Clean Architecture** pattern and utilizes a **Monorepo** structure managed by **Melos**.

The project is configured with multiple flavors (**Dev**, **Staging**, **Prod**) and integrates **Firebase** for backend services. It also includes a custom local package for KHQR scanning.

## Tech Stack & Architecture

*   **Framework:** Flutter (Dart)
*   **State Management:** Riverpod (`flutter_riverpod`, `riverpod_annotation`)
*   **Architecture:** Clean Architecture (Core, Data, Domain, Presentation)
*   **Workspace Management:** Melos (`melos.yaml`)
*   **Backend/Services:** Firebase (Core, likely Auth/Firestore/Messaging based on `google-services.json`)
*   **Navigation:** (Standard Navigator or GoRouter - checking `app.dart` suggested standard or similar)
*   **Localization:** JSON-based (`assets/locales/`)
*   **Networking:** `http` client
*   **Styling:** Custom `AppTheme` with Light/Dark mode support (`skeletonizer` for loading states)

## Project Structure

### Root Directory
*   `melos.yaml`: Defines the workspace and scripts for managing multiple packages.
*   `pubspec.yaml`: Main project dependencies.
*   `analysis_options.yaml`: Linting rules (`flutter_lints`).
*   `firebase.json`: Firebase CLI configuration.

### `lib/` (Main Application)
The application code follows Clean Architecture:
*   `lib/main.dart`: Application entry point. Handles initialization of Firebase and Flavors.
*   `lib/app.dart`: Root widget (`App`), sets up Theme, Localization, and Flavor Banner.
*   `lib/flavors.dart`: Flavor configuration (`dev`, `staging`, `prod`) and environment variables.
*   `lib/core/`: Core utilities, constants, and shared services.
*   `lib/data/`: Repositories implementations, data sources, and models.
*   `lib/domain/`: Entities, repositories interfaces, and use cases.
*   `lib/presentation/`: UI logic (Riverpod providers/notifiers) and Widgets (Views).

### `packages/` (Local Modules)
*   `packages/khqr_scan_package/`: A standalone Flutter package for QR code scanning logic, separating this feature from the main app.

### `assets/`
*   `fonts/`: Custom fonts (KantumruyPro).
*   `images/`: App assets (logos, flags).
*   `locales/`: Localization files (`en.json`, `km.json`, `zh.json`).
*   `lottie/`: Lottie animations.
*   `svg/`: SVG icons.

## Building and Running

### Prerequisites
*   Flutter SDK (Version matching `environment: sdk: ^3.10.7`)
*   Melos (`dart pub global activate melos`)

### Setup
1.  **Bootstrap the workspace:**
    ```bash
    melos bootstrap
    # OR
    melos bs
    ```
    This links local packages and installs dependencies.

2.  **Code Generation:**
    If using Riverpod generators or Freezed:
    ```bash
    dart run build_runner build -d
    ```

### Running the App
The app relies on **Flavors**. You typically need to specify the flavor and potentially the target file if separate entry points existed (though `main.dart` seems consolidated).

**Development:**
```bash
flutter run --flavor dev
```

**Staging:**
```bash
flutter run --flavor staging
```

**Production:**
```bash
flutter run --flavor prod
```

*Note: Verify if `dart-define` is needed for `appFlavor` in `main.dart`, e.g., `--dart-define=appFlavor=dev`.*

### Melos Scripts
Defined in `melos.yaml`:
*   `melos run get`: Run `flutter pub get` in all packages.
*   `melos run analyze`: Run lints.
*   `melos run test`: Run unit tests.

## Development Conventions

*   **Flavors:** Always respect the environment (Dev/Staging/Prod). Do not hardcode API URLs; use `F.baseUrl` from `flavors.dart`.
*   **Clean Architecture:**
    *   **Domain**: Pure Dart, no Flutter dependencies (except maybe minimal). Business logic here.
    *   **Data**: API calls, DB, DTOs.
    *   **Presentation**: UI and State Management.
*   **Localization:** Add new strings to `assets/locales/*.json`.
*   **Assets:** Use SVGs where possible for icons.
*   **Linting:** Ensure `flutter analyze` passes before committing.
