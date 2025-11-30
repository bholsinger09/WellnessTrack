import 'package:flutter_test/flutter_test.dart';
import 'package:wellness_tracker/features/mood_tracking/presentation/providers/mood_provider.dart';
import 'package:wellness_tracker/features/mood_tracking/domain/models/mood_log.dart';

void main() {
  group('MoodProvider', () {
    late MoodProvider provider;

    setUp(() {
      provider = MoodProvider();
    });

    test('should start with empty mood logs', () {
      expect(provider.moodLogs, isEmpty);
    });

    test('should add a mood log', () {
      final moodLog = MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.happy,
        timestamp: DateTime.now(),
      );

      provider.addMoodLog(moodLog);

      expect(provider.moodLogs.length, 1);
      expect(provider.moodLogs.first, moodLog);
    });

    test('should add multiple mood logs', () {
      final log1 = MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.happy,
        timestamp: DateTime.now(),
      );
      final log2 = MoodLog(
        id: '2',
        userId: 'user1',
        mood: MoodType.sad,
        timestamp: DateTime.now(),
      );

      provider.addMoodLog(log1);
      provider.addMoodLog(log2);

      expect(provider.moodLogs.length, 2);
    });

    test('should sort mood logs by timestamp descending', () {
      final log1 = MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.happy,
        timestamp: DateTime(2024, 1, 1),
      );
      final log2 = MoodLog(
        id: '2',
        userId: 'user1',
        mood: MoodType.neutral,
        timestamp: DateTime(2024, 1, 3),
      );
      final log3 = MoodLog(
        id: '3',
        userId: 'user1',
        mood: MoodType.sad,
        timestamp: DateTime(2024, 1, 2),
      );

      provider.addMoodLog(log1);
      provider.addMoodLog(log2);
      provider.addMoodLog(log3);

      expect(provider.moodLogs[0].id, '3'); // Most recent gets sorted to top
      expect(provider.moodLogs[1].id, '2');
      expect(provider.moodLogs[2].id, '1'); // Oldest
    });

    test('should remove a mood log by id', () {
      final log1 = MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.happy,
        timestamp: DateTime.now(),
      );
      final log2 = MoodLog(
        id: '2',
        userId: 'user1',
        mood: MoodType.sad,
        timestamp: DateTime.now(),
      );

      provider.addMoodLog(log1);
      provider.addMoodLog(log2);
      provider.removeMoodLog('1');

      expect(provider.moodLogs.length, 1);
      expect(provider.moodLogs.first.id, '2');
    });

    test('should get mood logs by date range', () {
      final log1 = MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.happy,
        timestamp: DateTime(2024, 1, 1),
      );
      final log2 = MoodLog(
        id: '2',
        userId: 'user1',
        mood: MoodType.neutral,
        timestamp: DateTime(2024, 1, 5),
      );
      final log3 = MoodLog(
        id: '3',
        userId: 'user1',
        mood: MoodType.sad,
        timestamp: DateTime(2024, 1, 10),
      );

      provider.addMoodLog(log1);
      provider.addMoodLog(log2);
      provider.addMoodLog(log3);

      final filtered = provider.getMoodLogsByDateRange(
        DateTime(2024, 1, 2),
        DateTime(2024, 1, 8),
      );

      expect(filtered.length, 1);
      expect(filtered.first.id, '2');
    });

    test('should notify listeners when mood log is added', () {
      var notified = false;
      provider.addListener(() {
        notified = true;
      });

      final moodLog = MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.happy,
        timestamp: DateTime.now(),
      );

      provider.addMoodLog(moodLog);
      expect(notified, true);
    });

    test('should notify listeners when mood log is removed', () {
      final moodLog = MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.happy,
        timestamp: DateTime.now(),
      );
      provider.addMoodLog(moodLog);

      var notified = false;
      provider.addListener(() {
        notified = true;
      });

      provider.removeMoodLog('1');
      expect(notified, true);
    });
  });
}
