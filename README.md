# Wellness Tracker 🧘‍♀️

A comprehensive wellness tracking mobile application built with Flutter and Firebase, designed specifically for university students.

## Features

- 📊 **Mood Check-ins**: Track your daily mood with visual feedback
- 📈 **Sleep + Study Balance**: Monitor and visualize your sleep and study patterns
- ⏱️ **Meditation Timer**: Built-in meditation and stress-relief timer
- 💬 **Anonymous Peer Support**: Connect with peers anonymously for support
- 🤖 **AI Journaling Assistant**: AI-powered journaling with personalized insights

## Tech Stack

- **Frontend**: Flutter (iOS, Android, Windows)
- **Backend**: Firebase (Firestore, Auth, Realtime Database, Functions)
- **Architecture**: Clean Architecture with BLoC pattern
- **Testing**: Test-Driven Development (TDD)

## Project Structure

```
lib/
├── core/                    # Core utilities and base classes
│   ├── constants/
│   ├── errors/
│   ├── theme/
│   └── utils/
├── features/                # Feature modules
│   ├── auth/
│   ├── mood_tracking/
│   ├── sleep_study/
│   ├── meditation/
│   ├── chat/
│   └── journal/
└── main.dart

test/                        # Test files mirror lib structure
```

## Setup Instructions

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Firebase CLI
- Xcode (for iOS)
- Android Studio (for Android)
- Visual Studio (for Windows)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd TrackWellness
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   ```bash
   firebase login
   flutterfire configure
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/mood_tracking/mood_tracking_test.dart
```

## Firebase Configuration

This app requires the following Firebase services:
- **Authentication**: Email/Password, Anonymous
- **Firestore**: User data, mood logs, sleep/study data
- **Realtime Database**: Chat messages
- **Cloud Functions**: AI journaling integration

## Platform Support

- ✅ iOS
- ✅ Android
- ✅ Windows

## Contributing

1. Follow the existing architecture patterns
2. Write tests for new features (TDD approach)
3. Run `flutter analyze` before committing
4. Follow Flutter style guide

## License

MIT License
