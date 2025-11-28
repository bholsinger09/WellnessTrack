import 'package:flutter_test/flutter_test.dart';
import 'package:wellness_tracker/features/meditation/domain/models/meditation_session.dart';

void main() {
  group('MeditationSession', () {
    test('should create a valid MeditationSession', () {
      final startTime = DateTime(2024, 1, 1, 10, 0);
      final endTime = DateTime(2024, 1, 1, 10, 15);

      final session = MeditationSession(
        id: '123',
        userId: 'user123',
        startTime: startTime,
        endTime: endTime,
        durationMinutes: 15,
        meditationType: 'Mindfulness',
        notes: 'Great session!',
      );

      expect(session.id, '123');
      expect(session.userId, 'user123');
      expect(session.durationMinutes, 15);
      expect(session.meditationType, 'Mindfulness');
    });

    test('should convert to JSON correctly', () {
      final startTime = DateTime(2024, 1, 1, 10, 0);
      final endTime = DateTime(2024, 1, 1, 10, 15);

      final session = MeditationSession(
        id: '123',
        userId: 'user123',
        startTime: startTime,
        endTime: endTime,
        durationMinutes: 15,
        meditationType: 'Mindfulness',
      );

      final json = session.toJson();

      expect(json['id'], '123');
      expect(json['userId'], 'user123');
      expect(json['durationMinutes'], 15);
      expect(json['meditationType'], 'Mindfulness');
    });

    test('should create from JSON correctly', () {
      final json = {
        'id': '123',
        'userId': 'user123',
        'startTime': '2024-01-01T10:00:00.000',
        'endTime': '2024-01-01T10:15:00.000',
        'durationMinutes': 15,
        'meditationType': 'Mindfulness',
        'notes': 'Great session!',
      };

      final session = MeditationSession.fromJson(json);

      expect(session.id, '123');
      expect(session.userId, 'user123');
      expect(session.durationMinutes, 15);
      expect(session.notes, 'Great session!');
    });

    test('should handle null optional fields', () {
      final session = MeditationSession(
        id: '123',
        userId: 'user123',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        durationMinutes: 10,
      );

      expect(session.meditationType, null);
      expect(session.notes, null);
    });
  });
}
