
# Task Manager App

This is a Flutter-based Task Manager application that follows Clean Architecture principles. The app features task creation, updating, marking as completed, filtering, and dark mode, using the Bloc state management approach.

---

## Features
- Add, update, and delete tasks.
- Mark tasks as completed and view completed tasks separately.
- Filter and sort tasks.
- Persistent storage using Hive.
- Dark mode support.

---

## Prerequisites

### **System Requirements**
1. **Flutter**:
   - Flutter SDK version: **>=3.0.0**.
   - Verify your Flutter installation:
     ```bash
     flutter doctor
     ```

2. **Dart**:
   - Dart version included with the Flutter SDK.

3. **Supported Platforms**:
   - **Android**: API level **19** (Android 4.4, KitKat) and above.
   - **iOS**: iOS version **12.0** and above.

4. **IDE**:
   - Use any IDE that supports Flutter (e.g., Android Studio, VS Code, IntelliJ IDEA).

---

## Getting Started

### Step 1: Clone the Repository
Clone the repository to your local system:
```bash
git clone <repository-url>
cd <project-folder>
```

### Step 2: Install Dependencies
Run the following command to install all dependencies listed in `pubspec.yaml`:
```bash
flutter pub get
```

### Step 3: Initialize Hive
Hive requires initialization. Ensure the following code exists in your `main.dart`:
```dart
await Hive.initFlutter();
```

### Step 4: Run the Application
Use the following command to run the app on your device or emulator:
```bash
flutter run
```

---

## Building the App

### For Android:
1. Run the following command to build an APK:
   ```bash
   flutter build apk --release
   ```
2. The generated APK will be available in:
   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

### For iOS:
1. Ensure Xcode is installed on macOS.
2. Run the following command to build for iOS:
   ```bash
   flutter build ios --release
   ```
3. Open the generated project in Xcode to archive and deploy.

---

## Project Structure
This project follows a **Clean Architecture** structure:
```
lib/
├── core/                # Core utilities and themes
├── features/
│   ├── task_manager/
│   │   ├── data/        # Models, repositories, and data sources
│   │   ├── domain/      # Entities and use cases
│   │   └── presentation/
│   │       ├── blocs/   # Bloc files for state management
│   │       └── screens/ # UI screens
└── main.dart            # App entry point
```

---

## Key Packages
- **Bloc**: State management (`flutter_bloc`)
- **Hive**: Local storage (`hive_flutter`)
- **Material**: UI components

---

## Supported API Levels
- **Android**: API level **19** (Android 4.4, KitKat) and above.
- **iOS**: iOS version **12.0** and above.

---

## Troubleshooting

1. **Missing Dependencies**:  
   Run:
   ```bash
   flutter pub get
   ```

2. **Hive Issues**:  
   Ensure Hive is initialized properly before running the app:
   ```dart
   await Hive.initFlutter();
   ```

3. **Build Errors**:  
   Ensure the correct Flutter SDK version is installed. Use:
   ```bash
   flutter doctor
   ```

---
# scaleup-taskmanagement-by-Moneesh
