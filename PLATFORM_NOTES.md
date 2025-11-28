# Platform-Specific Implementation Notes

## iOS Setup

### Requirements
- macOS with Xcode 14.0 or later
- CocoaPods installed
- iOS 12.0+ deployment target

### Configuration Steps

1. **Open Xcode Project**
   ```bash
   cd ios
   open Runner.xcworkspace
   ```

2. **Configure Signing**
   - Select Runner target
   - Go to "Signing & Capabilities"
   - Select your development team
   - Update bundle identifier if needed

3. **Update Info.plist**
   Add required permissions in `ios/Runner/Info.plist`:
   ```xml
   <key>NSPhotoLibraryUsageDescription</key>
   <string>We need access to your photo library for profile pictures</string>
   <key>NSCameraUsageDescription</key>
   <string>We need camera access for profile pictures</string>
   <key>NSMicrophoneUsageDescription</key>
   <string>Needed for meditation audio guidance</string>
   ```

4. **Firebase Setup**
   - `GoogleService-Info.plist` should be in `ios/Runner/`
   - Verify in Xcode project navigator

5. **Build and Run**
   ```bash
   flutter build ios --release
   ```

### Common iOS Issues

**Issue: Pods not found**
```bash
cd ios
pod deintegrate
pod install
cd ..
```

**Issue: Code signing**
- Use Xcode's automatic signing
- Or configure manual signing with provisioning profiles

**Issue: Firebase not connecting**
- Verify `GoogleService-Info.plist` is in project
- Clean build: `flutter clean && cd ios && pod install`

## Android Setup

### Requirements
- Android Studio or Android SDK
- Java 11+
- Android API level 21+ (Android 5.0)

### Configuration Steps

1. **Update build.gradle**
   Verify `android/app/build.gradle`:
   ```gradle
   android {
       compileSdkVersion 34
       
       defaultConfig {
           minSdkVersion 21
           targetSdkVersion 34
       }
   }
   ```

2. **Firebase Setup**
   - `google-services.json` should be in `android/app/`
   - Verify Google Services plugin is applied

3. **Permissions**
   Add to `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   <uses-permission android:name="android.permission.CAMERA"/>
   <uses-permission android:name="android.permission.VIBRATE"/>
   ```

4. **Build and Run**
   ```bash
   flutter build apk --release
   flutter build appbundle --release  # For Play Store
   ```

### Common Android Issues

**Issue: Gradle build fails**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

**Issue: MultiDex error**
Add to `android/app/build.gradle`:
```gradle
defaultConfig {
    multiDexEnabled true
}

dependencies {
    implementation 'androidx.multidex:multidex:2.0.1'
}
```

**Issue: Firebase not connecting**
- Verify `google-services.json` location
- Check package name matches Firebase console

## Windows Setup

### Requirements
- Windows 10 version 1809 or later
- Visual Studio 2022 with Desktop development C++
- Windows SDK

### Configuration Steps

1. **Enable Windows Desktop**
   ```bash
   flutter config --enable-windows-desktop
   ```

2. **Build Project**
   ```bash
   flutter build windows --release
   ```

3. **Run on Windows**
   ```bash
   flutter run -d windows
   ```

### Firebase on Windows

Firebase on Windows requires additional setup:
1. Use Firebase Web SDK configuration
2. Or use Firebase REST API
3. Windows support is experimental for some Firebase features

### Common Windows Issues

**Issue: Visual Studio not found**
- Install Visual Studio 2022
- Select "Desktop development with C++"
- Install Windows 10/11 SDK

**Issue: Build fails**
```bash
flutter clean
flutter pub get
flutter build windows
```

## Web Setup (Optional)

### Enable Web Support
```bash
flutter config --enable-web
flutter create . --platforms web
```

### Build for Web
```bash
flutter build web --release
```

### Firebase Web Configuration
Add Firebase config to `web/index.html`:
```html
<script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-firestore.js"></script>
```

## Platform-Specific Features

### iOS Only
- Face ID/Touch ID authentication
- Apple Health integration
- App Store distribution
- TestFlight beta testing

### Android Only
- Google Fit integration
- Google Play distribution
- In-app updates
- Play Console testing

### Windows Only
- Windows Hello integration
- Microsoft Store distribution
- Desktop notifications
- System tray integration

## Distribution

### iOS App Store

1. **Prepare for Release**
   - Update version in `pubspec.yaml`
   - Update build number
   - Create app icons (1024x1024)

2. **Build Archive**
   ```bash
   flutter build ios --release
   ```

3. **Submit via Xcode**
   - Open Xcode
   - Product → Archive
   - Upload to App Store Connect

### Google Play Store

1. **Prepare for Release**
   - Update version in `pubspec.yaml`
   - Create keystore for signing
   - Configure signing in `android/app/build.gradle`

2. **Build Bundle**
   ```bash
   flutter build appbundle --release
   ```

3. **Upload to Play Console**
   - Go to Google Play Console
   - Create new release
   - Upload AAB file

### Microsoft Store

1. **Package for Store**
   ```bash
   flutter build windows --release
   ```

2. **Create MSIX Package**
   - Use MSIX packaging tool
   - Or Windows Application Packaging Project

3. **Submit to Microsoft Store**
   - Upload via Partner Center

## Performance Optimization

### iOS
- Enable bitcode if needed
- Optimize app size with `--split-debug-info`
- Use ProGuard for release builds

### Android
- Enable R8/ProGuard obfuscation
- Use app bundles for smaller downloads
- Optimize images and assets

### Windows
- Minimize DLL dependencies
- Optimize startup time
- Bundle only required runtime files

## Testing on Real Devices

### iOS
```bash
# List devices
flutter devices

# Run on specific device
flutter run -d "iPhone 15 Pro"

# Install on connected device
flutter install
```

### Android
```bash
# List devices
adb devices

# Run on specific device
flutter run -d <device-id>

# Install APK
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Windows
```bash
# Run on Windows
flutter run -d windows
```

## Debugging

### iOS Debugging
- Use Xcode for native debugging
- View logs in Xcode console
- Use Instruments for performance profiling

### Android Debugging
- Use Android Studio for native debugging
- View logs: `adb logcat`
- Use Android Profiler

### Windows Debugging
- Use Visual Studio debugger
- View logs in Visual Studio output
- Use Performance Profiler

## Platform-Specific Packages

Some features may require platform-specific packages:

```yaml
dependencies:
  # iOS/Android only
  image_picker: ^1.0.0
  camera: ^0.10.0
  
  # Cross-platform with limitations
  shared_preferences: ^2.2.0
  url_launcher: ^6.2.0
  
  # Windows-specific
  win32: ^5.0.0  # If needed
```

## Known Limitations

### iOS
- Background processing limited
- File system access restricted
- Some APIs require Apple approval

### Android
- Battery optimization affects background tasks
- Permissions vary by Android version
- Fragment navigation can be tricky

### Windows
- Firebase support is limited
- Some mobile packages don't work
- Desktop-specific APIs needed

## Resources

- [Flutter iOS Setup](https://docs.flutter.dev/get-started/install/macos)
- [Flutter Android Setup](https://docs.flutter.dev/get-started/install/windows)
- [Flutter Windows Setup](https://docs.flutter.dev/get-started/install/windows)
- [Firebase iOS Setup](https://firebase.google.com/docs/ios/setup)
- [Firebase Android Setup](https://firebase.google.com/docs/android/setup)
