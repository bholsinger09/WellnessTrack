import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wellness_tracker/core/providers/theme_provider.dart';

void main() {
  group('ThemeProvider', () {
    late ThemeProvider provider;

    setUp(() {
      provider = ThemeProvider();
    });

    test('should start with system theme mode', () {
      expect(provider.themeMode, ThemeMode.system);
    });

    test('should set theme mode to light', () {
      provider.setThemeMode(ThemeMode.light);
      expect(provider.themeMode, ThemeMode.light);
    });

    test('should set theme mode to dark', () {
      provider.setThemeMode(ThemeMode.dark);
      expect(provider.themeMode, ThemeMode.dark);
    });

    test('should set theme mode to system', () {
      provider.setThemeMode(ThemeMode.light);
      provider.setThemeMode(ThemeMode.system);
      expect(provider.themeMode, ThemeMode.system);
    });

    test('should toggle theme from light to dark', () {
      provider.setThemeMode(ThemeMode.light);
      provider.toggleTheme();
      expect(provider.themeMode, ThemeMode.dark);
    });

    test('should toggle theme from dark to system', () {
      provider.setThemeMode(ThemeMode.dark);
      provider.toggleTheme();
      expect(provider.themeMode, ThemeMode.system);
    });

    test('should toggle theme from system to light', () {
      provider.setThemeMode(ThemeMode.system);
      provider.toggleTheme();
      expect(provider.themeMode, ThemeMode.light);
    });

    test('should return correct theme mode label for light', () {
      provider.setThemeMode(ThemeMode.light);
      expect(provider.themeModeLabel, 'Light');
    });

    test('should return correct theme mode label for dark', () {
      provider.setThemeMode(ThemeMode.dark);
      expect(provider.themeModeLabel, 'Dark');
    });

    test('should return correct theme mode label for system', () {
      provider.setThemeMode(ThemeMode.system);
      expect(provider.themeModeLabel, 'System');
    });

    test('should return isDarkMode true when theme is dark', () {
      provider.setThemeMode(ThemeMode.dark);
      expect(provider.isDarkMode, true);
    });

    test('should return isDarkMode false when theme is light', () {
      provider.setThemeMode(ThemeMode.light);
      expect(provider.isDarkMode, false);
    });

    test('should return isDarkMode false when theme is system', () {
      provider.setThemeMode(ThemeMode.system);
      expect(provider.isDarkMode, false);
    });

    test('should notify listeners when theme mode changes', () {
      var notified = false;
      provider.addListener(() {
        notified = true;
      });

      provider.setThemeMode(ThemeMode.dark);
      expect(notified, true);
    });

    test('should notify listeners when theme is toggled', () {
      var notifyCount = 0;
      provider.addListener(() {
        notifyCount++;
      });

      provider.toggleTheme();
      expect(notifyCount, 1);

      provider.toggleTheme();
      expect(notifyCount, 2);
    });
  });
}
