# Wellness Tracker - Quick Start Guide

## 🚀 Get Started in 5 Minutes

### Step 1: Prerequisites

Install the required tools:

```bash
# Install Flutter (macOS)
brew install flutter

# Verify installation
flutter doctor
```

### Step 2: Clone and Setup

```bash
# Clone the repository
git clone <your-repo-url>
cd TrackWellness

# Install dependencies
flutter pub get
```

### Step 3: Firebase Setup (Quick)

```bash
# Install Firebase CLI
npm install -g firebase-tools
dart pub global activate flutterfire_cli

# Login to Firebase
firebase login

# Configure Firebase for your project
flutterfire configure
```

Follow the prompts to:
1. Select or create a Firebase project
2. Choose platforms: iOS, Android, Windows
3. This generates `firebase_options.dart` automatically

### Step 4: Enable Firebase Services

Go to [Firebase Console](https://console.firebase.google.com/):

1. **Authentication** → Enable Email/Password and Anonymous
2. **Firestore Database** → Create database (start in test mode)
3. **Realtime Database** → Create database (for chat)

### Step 5: Run the App!

```bash
# Run on connected device or emulator
flutter run

# Or specify platform
flutter run -d chrome        # Web
flutter run -d macos         # macOS
flutter run -d windows       # Windows
```

## 📱 Platform-Specific Setup

### iOS (macOS only)

```bash
cd ios
pod install
cd ..
flutter run -d ios
```

Requirements:
- macOS with Xcode installed
- iOS Simulator or physical device

### Android

Requirements:
- Android Studio or Android SDK
- Android Emulator or physical device

```bash
flutter run -d android
```

### Windows

```bash
flutter config --enable-windows-desktop
flutter run -d windows
```

## 🧪 Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/features/auth/domain/models/user_model_test.dart
```

## 🛠️ Common Commands

```bash
# Clean build
flutter clean

# Analyze code
flutter analyze

# Format code
flutter format .

# Generate build
flutter build apk          # Android
flutter build ios          # iOS
flutter build windows      # Windows
```

## 📚 Project Structure Overview

```
lib/
├── main.dart                    # App entry point
├── core/                        # Shared utilities
│   ├── theme/                   # App theme
│   ├── routes/                  # Navigation
│   └── constants/               # Constants
└── features/                    # Feature modules
    ├── auth/                    # Authentication
    ├── mood_tracking/           # Mood check-ins
    ├── sleep_study/             # Sleep & study tracking
    ├── meditation/              # Meditation timer
    ├── chat/                    # Peer support chat
    └── journal/                 # AI journaling
```

## 🎨 Features

✅ **Authentication** - Email/password and anonymous sign-in
✅ **Mood Tracking** - Log daily moods with notes
✅ **Sleep & Study Balance** - Track and visualize data
✅ **Meditation Timer** - Guided meditation sessions
✅ **Peer Support Chat** - Anonymous group support
✅ **AI Journal** - AI-powered journaling assistant

## 🐛 Troubleshooting

### Firebase Connection Issues

```bash
# Regenerate Firebase configuration
flutterfire configure

# Verify firebase_options.dart exists
ls lib/firebase_options.dart
```

### Build Issues

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### iOS Pod Issues

```bash
cd ios
rm Podfile.lock
pod install --repo-update
cd ..
```

## 📖 Documentation

- [Full README](README.md)
- [Firebase Setup Guide](FIREBASE_SETUP.md)
- [Development Guide](DEVELOPMENT_GUIDE.md)

## 🤝 Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📞 Support

- Create an issue on GitHub
- Check existing documentation
- Review closed issues for solutions

## 🎯 Next Steps

1. ✅ Run the app
2. 📱 Create an account
3. 🧪 Explore features
4. 🔧 Customize for your needs
5. 🚀 Deploy to production

Happy coding! 🎉
