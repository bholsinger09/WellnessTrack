import 'package:flutter_test/flutter_test.dart';
import 'package:wellness_tracker/features/sleep_study/domain/entities/sleep_log.dart';

void main() {
  group('SleepLog', () {
    test('should create a valid SleepLog', () {
      final sleepLog = SleepLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 8.0,
        notes: 'Slept well',
      );

      expect(sleepLog.id, '123');
      expect(sleepLog.date, DateTime(2024, 1, 1));
      expect(sleepLog.hours, 8.0);
      expect(sleepLog.notes, 'Slept well');
    });

    test('should create SleepLog with bedTime and wakeTime', () {
      final bedTime = DateTime(2024, 1, 1, 22, 0);
      final wakeTime = DateTime(2024, 1, 2, 6, 0);
      
      final sleepLog = SleepLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 8.0,
        bedTime: bedTime,
        wakeTime: wakeTime,
      );

      expect(sleepLog.bedTime, bedTime);
      expect(sleepLog.wakeTime, wakeTime);
    });

    test('should handle null optional fields', () {
      final sleepLog = SleepLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 7.5,
      );

      expect(sleepLog.notes, null);
      expect(sleepLog.bedTime, null);
      expect(sleepLog.wakeTime, null);
    });

    test('should create a copy with updated values', () {
      final original = SleepLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 7.0,
        notes: 'Original note',
      );

      final updated = original.copyWith(
        hours: 8.0,
        notes: 'Updated note',
      );

      expect(updated.id, '123');
      expect(updated.date, DateTime(2024, 1, 1));
      expect(updated.hours, 8.0);
      expect(updated.notes, 'Updated note');
    });

    test('should maintain original values when copying without changes', () {
      final original = SleepLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 7.0,
        notes: 'Original note',
      );

      final copy = original.copyWith();

      expect(copy.id, original.id);
      expect(copy.date, original.date);
      expect(copy.hours, original.hours);
      expect(copy.notes, original.notes);
    });

    test('should support equality comparison', () {
      final log1 = SleepLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 8.0,
      );

      final log2 = SleepLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 8.0,
      );

      expect(log1, equals(log2));
    });

    test('should support different instances with same values', () {
      final log1 = SleepLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 8.0,
        notes: 'Good sleep',
      );

      final log2 = SleepLog(
        id: '123',
        date: DateTime(2024, 1, 1),
        hours: 8.0,
        notes: 'Good sleep',
      );

      expect(log1 == log2, true);
    });
  });
}
