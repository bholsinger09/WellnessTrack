# Development Guide

## Getting Started

### Prerequisites

- Flutter SDK (3.19.0 or higher)
- Dart SDK (3.0.0 or higher)
- Firebase CLI
- Git
- IDE: VS Code or Android Studio

### Initial Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd TrackWellness
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Set up Firebase (see FIREBASE_SETUP.md)

4. Run the app:
   ```bash
   flutter run
   ```

## Project Architecture

### Clean Architecture + Feature-First

```
lib/
├── core/                    # Shared utilities, theme, constants
│   ├── constants/           # App-wide constants
│   ├── errors/              # Error handling
│   ├── routes/              # Navigation configuration
│   ├── theme/               # App theme
│   └── utils/               # Helper functions
│
├── features/                # Feature modules (bounded contexts)
│   ├── auth/
│   │   ├── data/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   └── models/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   ├── mood_tracking/
│   ├── sleep_study/
│   ├── meditation/
│   ├── chat/
│   └── journal/
│
└── main.dart
```

### Layers Explanation

1. **Presentation Layer**: UI components, screens, providers
2. **Domain Layer**: Business logic, models
3. **Data Layer**: Repositories, data sources (Firebase)

## Coding Standards

### Naming Conventions

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `UPPER_SNAKE_CASE`
- **Private members**: `_leadingUnderscore`

### Flutter Best Practices

1. Always use `const` constructors when possible
2. Prefer composition over inheritance
3. Keep widgets small and focused
4. Use meaningful widget names
5. Extract reusable widgets
6. Avoid deep nesting (max 3-4 levels)

### State Management

- Use `Provider` for global state (auth, theme)
- Use `StatefulWidget` for local UI state
- Consider `BLoC` for complex business logic

## Testing

### Test Structure

```
test/
├── features/
│   ├── auth/
│   │   ├── domain/
│   │   │   └── models/
│   │   │       └── user_model_test.dart
│   │   └── data/
│   │       └── repositories/
│   │           └── auth_repository_test.dart
│   └── ...
└── widget_test.dart
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/auth/domain/models/user_model_test.dart

# Run tests with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Test-Driven Development (TDD)

1. **Red**: Write a failing test
2. **Green**: Write minimal code to pass the test
3. **Refactor**: Improve code while keeping tests green

Example:
```dart
// 1. Write test first
test('should return correct mood emoji', () {
  final mood = MoodType.happy;
  expect(mood.emoji, '🙂');
});

// 2. Implement feature
// 3. Refactor if needed
```

### Testing Best Practices

- Test one thing at a time
- Use descriptive test names
- Follow AAA pattern: Arrange, Act, Assert
- Mock external dependencies (Firebase, APIs)
- Aim for 80%+ code coverage

## Git Workflow

### Branch Naming

- `feature/mood-tracking` - New features
- `bugfix/login-error` - Bug fixes
- `hotfix/critical-crash` - Production hotfixes
- `refactor/auth-structure` - Code improvements

### Commit Messages

Follow conventional commits:

```
feat: add mood check-in feature
fix: resolve login authentication error
docs: update Firebase setup guide
test: add tests for mood log model
refactor: improve auth repository structure
style: format code according to style guide
```

### Pull Request Process

1. Create feature branch from `develop`
2. Make changes with clear commits
3. Write/update tests
4. Run tests and ensure they pass
5. Update documentation if needed
6. Create PR to `develop`
7. Address review comments
8. Merge after approval

## Firebase Integration

### Firestore Operations

```dart
// Create
await FirebaseFirestore.instance
  .collection('mood_logs')
  .doc(id)
  .set(moodLog.toJson());

// Read
final doc = await FirebaseFirestore.instance
  .collection('mood_logs')
  .doc(id)
  .get();

// Update
await FirebaseFirestore.instance
  .collection('mood_logs')
  .doc(id)
  .update({'mood': 'happy'});

// Delete
await FirebaseFirestore.instance
  .collection('mood_logs')
  .doc(id)
  .delete();

// Query
final snapshot = await FirebaseFirestore.instance
  .collection('mood_logs')
  .where('userId', isEqualTo: userId)
  .orderBy('timestamp', descending: true)
  .limit(10)
  .get();
```

### Error Handling

```dart
try {
  await firebaseOperation();
} on FirebaseException catch (e) {
  if (e.code == 'permission-denied') {
    // Handle permission error
  } else if (e.code == 'not-found') {
    // Handle not found error
  }
} catch (e) {
  // Handle general error
}
```

## Performance Optimization

### Flutter Performance

1. Use `const` constructors
2. Avoid rebuilding entire widget trees
3. Use `ListView.builder` for long lists
4. Implement pagination for large datasets
5. Cache network images
6. Use `RepaintBoundary` for complex widgets

### Firebase Performance

1. Use indexes for queries
2. Implement pagination
3. Cache frequently accessed data
4. Use batch writes for multiple operations
5. Optimize security rules

## Debugging

### Common Issues

1. **Firebase connection fails**
   - Check `firebase_options.dart` exists
   - Verify internet connection
   - Check Firebase project configuration

2. **Build fails on iOS**
   - Run `flutter clean`
   - Delete `Podfile.lock`
   - Run `pod install` in ios folder

3. **State not updating**
   - Call `notifyListeners()` in providers
   - Use `Consumer` or `watch` correctly

### Debug Tools

```bash
# Flutter DevTools
flutter pub global activate devtools
flutter pub global run devtools

# Flutter Inspector
# Available in VS Code and Android Studio

# Performance profiling
flutter run --profile
```

## Deployment

### Android

```bash
# Generate release APK
flutter build apk --release

# Generate App Bundle (recommended)
flutter build appbundle --release
```

### iOS

```bash
# Build for iOS
flutter build ios --release

# Archive in Xcode and upload to App Store Connect
```

### Windows

```bash
# Build for Windows
flutter build windows --release
```

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Provider Package](https://pub.dev/packages/provider)

## Support

For questions or issues:
1. Check existing documentation
2. Search GitHub issues
3. Create a new issue with details
4. Contact the maintainers
