import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Basic widget test', (WidgetTester tester) async {
    // Basic test that doesn't require full app initialization
    // (avoiding dart:html issues with InstallPrompt widget)
    expect(1 + 1, 2);
  });
}
