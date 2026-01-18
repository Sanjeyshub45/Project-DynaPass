# How to Build and Download Your Password Generator App

## Prerequisites
1. Make sure Flutter is installed and configured
2. Connect your device or use an emulator

## Building for Android

### Option 1: Build Debug APK (for testing)
```bash
cd /Users/sanjeys/Desktop/demo_appvs
flutter build apk --debug
```
The APK will be at: `build/app/outputs/flutter-apk/app-debug.apk`

### Option 2: Build Release APK (optimized, for distribution)
```bash
flutter build apk --release
```
The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

### Option 3: Build App Bundle (for Google Play Store)
```bash
flutter build appbundle --release
```
The bundle will be at: `build/app/outputs/bundle/release/app-release.aab`

### Installing APK on Android Device
1. Transfer the APK file to your Android device (via USB, email, or cloud storage)
2. On your device, go to Settings → Security → Enable "Unknown Sources" or "Install from Unknown Sources"
3. Open the APK file on your device and tap "Install"

## Building for iOS (Mac only)

### Build for iOS Simulator
```bash
flutter build ios --simulator
```

### Build for Physical iOS Device
1. Open the project in Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```
2. Select your device or "Any iOS Device" in Xcode
3. Product → Archive (for App Store) or Product → Run (for direct install)
4. For direct install, you'll need to sign the app with your Apple Developer account

## Building for Web

```bash
flutter build web
```
Output will be in: `build/web/`

## Quick Test Run

### Run on Connected Device/Emulator
```bash
flutter run
```

### Run on Specific Device
```bash
flutter devices  # List available devices
flutter run -d <device-id>
```

## Troubleshooting

- If you get permission errors, make sure Flutter is properly installed
- For Android, ensure you have Android Studio and Android SDK installed
- For iOS, ensure you have Xcode installed (Mac only)
- Make sure your device is connected and USB debugging is enabled (Android)
