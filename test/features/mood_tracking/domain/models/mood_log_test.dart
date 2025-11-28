import 'package:flutter_test/flutter_test.dart';
import 'package:wellness_tracker/features/mood_tracking/domain/models/mood_log.dart';

void main() {
  group('MoodLog', () {
    test('should create a valid MoodLog', () {
      final moodLog = MoodLog(
        id: '123',
        userId: 'user123',
        mood: MoodType.happy,
        notes: 'Had a great day!',
        timestamp: DateTime(2024, 1, 1),
      );

      expect(moodLog.id, '123');
      expect(moodLog.userId, 'user123');
      expect(moodLog.mood, MoodType.happy);
      expect(moodLog.notes, 'Had a great day!');
    });

    test('should convert to JSON correctly', () {
      final moodLog = MoodLog(
        id: '123',
        userId: 'user123',
        mood: MoodType.happy,
        notes: 'Had a great day!',
        timestamp: DateTime(2024, 1, 1),
      );

      final json = moodLog.toJson();

      expect(json['id'], '123');
      expect(json['userId'], 'user123');
      expect(json['mood'], 'happy');
      expect(json['notes'], 'Had a great day!');
    });

    test('should create from JSON correctly', () {
      final json = {
        'id': '123',
        'userId': 'user123',
        'mood': 'happy',
        'notes': 'Had a great day!',
        'timestamp': '2024-01-01T00:00:00.000',
      };

      final moodLog = MoodLog.fromJson(json);

      expect(moodLog.id, '123');
      expect(moodLog.userId, 'user123');
      expect(moodLog.mood, MoodType.happy);
      expect(moodLog.notes, 'Had a great day!');
    });

    test('should return correct emoji for each mood type', () {
      expect(MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.veryHappy,
        timestamp: DateTime.now(),
      ).moodEmoji, '😄');

      expect(MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.happy,
        timestamp: DateTime.now(),
      ).moodEmoji, '🙂');

      expect(MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.neutral,
        timestamp: DateTime.now(),
      ).moodEmoji, '😐');

      expect(MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.sad,
        timestamp: DateTime.now(),
      ).moodEmoji, '😔');

      expect(MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.verySad,
        timestamp: DateTime.now(),
      ).moodEmoji, '😢');
    });

    test('should return correct label for each mood type', () {
      expect(MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.veryHappy,
        timestamp: DateTime.now(),
      ).moodLabel, 'Very Happy');

      expect(MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.happy,
        timestamp: DateTime.now(),
      ).moodLabel, 'Happy');

      expect(MoodLog(
        id: '1',
        userId: 'user1',
        mood: MoodType.neutral,
        timestamp: DateTime.now(),
      ).moodLabel, 'Neutral');
    });

    test('should handle null notes', () {
      final moodLog = MoodLog(
        id: '123',
        userId: 'user123',
        mood: MoodType.neutral,
        timestamp: DateTime(2024, 1, 1),
      );

      expect(moodLog.notes, null);
    });
  });
}
