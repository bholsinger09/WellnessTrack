import 'package:flutter_test/flutter_test.dart';
import 'package:wellness_tracker/features/sleep_study/domain/entities/study_log.dart';

void main() {
  group('StudyLog', () {
    test('should create a valid StudyLog', () {
      final studyLog = StudyLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 4.0,
        subject: 'Mathematics',
        notes: 'Studied calculus',
      );

      expect(studyLog.id, '123');
      expect(studyLog.date, DateTime(2024, 1, 1));
      expect(studyLog.hours, 4.0);
      expect(studyLog.subject, 'Mathematics');
      expect(studyLog.notes, 'Studied calculus');
    });

    test('should handle null optional fields', () {
      final studyLog = StudyLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 3.5,
      );

      expect(studyLog.subject, null);
      expect(studyLog.notes, null);
    });

    test('should create a copy with updated values', () {
      final original = StudyLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 3.0,
        subject: 'Physics',
        notes: 'Original note',
      );

      final updated = original.copyWith(
        hours: 4.0,
        subject: 'Chemistry',
        notes: 'Updated note',
      );

      expect(updated.id, '123');
      expect(updated.date, DateTime(2024, 1, 1));
      expect(updated.hours, 4.0);
      expect(updated.subject, 'Chemistry');
      expect(updated.notes, 'Updated note');
    });

    test('should maintain original values when copying without changes', () {
      final original = StudyLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 5.0,
        subject: 'Biology',
      );

      final copy = original.copyWith();

      expect(copy.id, original.id);
      expect(copy.date, original.date);
      expect(copy.hours, original.hours);
      expect(copy.subject, original.subject);
    });

    test('should support equality comparison', () {
      final log1 = StudyLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 4.0,
        subject: 'Math',
      );

      final log2 = StudyLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 4.0,
        subject: 'Math',
      );

      expect(log1, equals(log2));
    });

    test('should allow fractional hours', () {
      final studyLog = StudyLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 2.5,
      );

      expect(studyLog.hours, 2.5);
    });
  });
}
