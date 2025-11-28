import 'package:flutter_test/flutter_test.dart';
import 'package:wellness_tracker/main.dart';

void main() {
  testWidgets('App should launch successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const WellnessTrackerApp());

    // Verify the app launches
    expect(find.text('Wellness Tracker'), findsOneWidget);
  });
}
