# Contributing to Wellness Tracker

Thank you for your interest in contributing to Wellness Tracker! This document provides guidelines for contributing to the project.

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on what is best for the community
- Show empathy towards other contributors

## How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported in Issues
2. If not, create a new issue with:
   - Clear, descriptive title
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots if applicable
   - Environment details (OS, Flutter version, device)

### Suggesting Features

1. Check if the feature has been suggested
2. Create an issue with:
   - Clear description of the feature
   - Why it would be useful
   - Possible implementation approach
   - Mock-ups or examples if applicable

### Pull Requests

1. **Fork the repository**
   ```bash
   git clone https://github.com/yourusername/wellness-tracker.git
   cd wellness-tracker
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the coding standards (see below)
   - Write tests for new features
   - Update documentation as needed
   - Keep commits focused and atomic

4. **Test your changes**
   ```bash
   flutter test
   flutter analyze
   flutter format .
   ```

5. **Commit your changes**
   ```bash
   git commit -m "feat: add amazing feature"
   ```
   
   Follow conventional commits:
   - `feat:` - New feature
   - `fix:` - Bug fix
   - `docs:` - Documentation changes
   - `test:` - Adding or updating tests
   - `refactor:` - Code refactoring
   - `style:` - Formatting changes

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create Pull Request**
   - Provide clear description
   - Reference related issues
   - Include screenshots for UI changes
   - Ensure CI passes

## Coding Standards

### Dart/Flutter Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `flutter format .` before committing
- Keep functions small and focused
- Use meaningful names
- Add comments for complex logic
- Prefer composition over inheritance

### File Organization

```
feature_name/
├── data/
│   └── repositories/
├── domain/
│   └── models/
└── presentation/
    ├── providers/
    ├── screens/
    └── widgets/
```

### Testing

- Write tests for all new features
- Maintain test coverage above 80%
- Use descriptive test names
- Follow AAA pattern (Arrange, Act, Assert)
- Mock external dependencies

Example:
```dart
test('should return user when sign in is successful', () {
  // Arrange
  final email = 'test@example.com';
  final password = 'password123';
  
  // Act
  final result = await authRepository.signIn(
    email: email,
    password: password,
  );
  
  // Assert
  expect(result, isA<UserModel>());
  expect(result.email, email);
});
```

### Documentation

- Update README for significant changes
- Add inline comments for complex logic
- Update CHANGELOG.md
- Document public APIs
- Include examples in documentation

## Development Workflow

1. Pick an issue or create one
2. Assign yourself to the issue
3. Create a branch
4. Develop with TDD approach:
   - Write test (Red)
   - Implement feature (Green)
   - Refactor (Refactor)
5. Ensure tests pass
6. Submit PR
7. Address review comments
8. Merge after approval

## Review Process

All PRs require:
- ✅ Passing tests
- ✅ Code review approval
- ✅ No merge conflicts
- ✅ Updated documentation
- ✅ Following coding standards

## Getting Help

- Ask questions in Issues
- Check existing documentation
- Review closed PRs for examples
- Contact maintainers

## Recognition

Contributors will be:
- Listed in README
- Acknowledged in release notes
- Given credit for their work

Thank you for contributing to Wellness Tracker! 🎉
