# FACE-TESTER

A Flutter application for facial recognition testing and review, built with Google ML Kit.

## Features

- **Live Camera Detection** — Real-time face detection via device camera with bounding box overlay and face tracking IDs
- **Gallery Review** — Pick any image from your device and run face detection with results overlaid
- **Face Metrics** — Detection confidence, landmark tracking, and face count via ML Kit classification

## Tech Stack

| Component | Package |
|---|---|
| Face Detection | `google_mlkit_face_detection ^0.11.0` |
| Camera Feed | `camera ^0.11.0` |
| Image Picker | `image_picker ^1.1.0` |
| Permissions | `permission_handler ^11.0.0` |
| Framework | Flutter 3.41.4 (Dart 3.11.1) |

## Project Structure

```
lib/
  main.dart                          # App entry point
  screens/
    home_screen.dart                 # Navigation hub
    camera_screen.dart               # Live camera detection
    review_screen.dart               # Gallery image review
  services/
    face_detector_service.dart       # ML Kit wrapper
  widgets/
    face_overlay_painter.dart        # Bounding box renderer
```

## Setup

### Requirements

- Flutter 3.41.4+
- Android SDK (minSdkVersion 21+) or iOS 12+
- Windows Developer Mode enabled (for symlink support)

### Install

```powershell
git clone https://github.com/hneal055/FACE-TESTER.git
cd FACE-TESTER/app
flutter pub get
```

### Android Config

In `android/app/src/main/AndroidManifest.xml`, add:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

In `android/app/build.gradle`, set:

```gradle
minSdkVersion 21
```

### Run

```powershell
flutter devices       # list available targets
flutter run           # run on connected device
```

## Daily Dev Startup

A startup script is included to configure the environment, check dependencies, and list connected devices:

```powershell
& ".\start-dev.ps1"
```

## Repository

[github.com/hneal055/FACE-TESTER](https://github.com/hneal055/FACE-TESTER)
