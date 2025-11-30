import 'package:flutter_test/flutter_test.dart';
import 'package:wellness_tracker/features/sleep_study/presentation/providers/sleep_study_provider.dart';
import 'package:wellness_tracker/features/sleep_study/domain/entities/sleep_log.dart';
import 'package:wellness_tracker/features/sleep_study/domain/entities/study_log.dart';

void main() {
  group('SleepStudyProvider', () {
    late SleepStudyProvider provider;

    setUp(() {
      provider = SleepStudyProvider();
    });

    group('Sleep Logs', () {
      test('should start with empty sleep logs', () {
        expect(provider.sleepLogs, isEmpty);
      });

      test('should add a sleep log', () {
        final sleepLog = SleepLog(
          id: '1',
          date: DateTime(2024, 1, 1),
          hours: 8.0,
        );

        provider.addSleepLog(sleepLog);

        expect(provider.sleepLogs.length, 1);
        expect(provider.sleepLogs.first, sleepLog);
      });

      test('should add multiple sleep logs', () {
        final log1 = SleepLog(
          id: '1',
          date: DateTime(2024, 1, 1),
          hours: 8.0,
        );
        final log2 = SleepLog(
          id: '2',
          date: DateTime(2024, 1, 2),
          hours: 7.5,
        );

        provider.addSleepLog(log1);
        provider.addSleepLog(log2);

        expect(provider.sleepLogs.length, 2);
      });

      test('should sort sleep logs by date descending', () {
        final log1 = SleepLog(
          id: '1',
          date: DateTime(2024, 1, 1),
          hours: 8.0,
        );
        final log2 = SleepLog(
          id: '2',
          date: DateTime(2024, 1, 3),
          hours: 7.5,
        );
        final log3 = SleepLog(
          id: '3',
          date: DateTime(2024, 1, 2),
          hours: 7.0,
        );

        provider.addSleepLog(log1);
        provider.addSleepLog(log2);
        provider.addSleepLog(log3);

        expect(provider.sleepLogs[0].id, '2'); // Most recent
        expect(provider.sleepLogs[1].id, '3');
        expect(provider.sleepLogs[2].id, '1'); // Oldest
      });

      test('should remove a sleep log by id', () {
        final log1 = SleepLog(
          id: '1',
          date: DateTime(2024, 1, 1),
          hours: 8.0,
        );
        final log2 = SleepLog(
          id: '2',
          date: DateTime(2024, 1, 2),
          hours: 7.5,
        );

        provider.addSleepLog(log1);
        provider.addSleepLog(log2);
        provider.removeSleepLog('1');

        expect(provider.sleepLogs.length, 1);
        expect(provider.sleepLogs.first.id, '2');
      });

      test('should get sleep logs by date range', () {
        final log1 = SleepLog(
          id: '1',
          date: DateTime(2024, 1, 1),
          hours: 8.0,
        );
        final log2 = SleepLog(
          id: '2',
          date: DateTime(2024, 1, 5),
          hours: 7.5,
        );
        final log3 = SleepLog(
          id: '3',
          date: DateTime(2024, 1, 10),
          hours: 7.0,
        );

        provider.addSleepLog(log1);
        provider.addSleepLog(log2);
        provider.addSleepLog(log3);

        final filtered = provider.getSleepLogsByDateRange(
          DateTime(2024, 1, 2),
          DateTime(2024, 1, 8),
        );

        expect(filtered.length, 1);
        expect(filtered.first.id, '2');
      });

      test('should calculate average sleep hours', () {
        final now = DateTime.now();
        final log1 = SleepLog(
          id: '1',
          date: DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1)),
          hours: 8.0,
        );
        final log2 = SleepLog(
          id: '2',
          date: DateTime(now.year, now.month, now.day).subtract(const Duration(days: 2)),
          hours: 6.0,
        );

        provider.addSleepLog(log1);
        provider.addSleepLog(log2);

        final average = provider.getAverageSleepHours();
        expect(average, 7.0);
      });

      test('should return 0 for average when no sleep logs', () {
        final average = provider.getAverageSleepHours();
        expect(average, 0);
      });
    });

    group('Study Logs', () {
      test('should start with empty study logs', () {
        expect(provider.studyLogs, isEmpty);
      });

      test('should add a study log', () {
        final studyLog = StudyLog(
          id: '1',
          date: DateTime(2024, 1, 1),
          hours: 4.0,
        );

        provider.addStudyLog(studyLog);

        expect(provider.studyLogs.length, 1);
        expect(provider.studyLogs.first, studyLog);
      });

      test('should add multiple study logs', () {
        final log1 = StudyLog(
          id: '1',
          date: DateTime(2024, 1, 1),
          hours: 4.0,
        );
        final log2 = StudyLog(
          id: '2',
          date: DateTime(2024, 1, 2),
          hours: 3.5,
        );

        provider.addStudyLog(log1);
        provider.addStudyLog(log2);

        expect(provider.studyLogs.length, 2);
      });

      test('should sort study logs by date descending', () {
        final log1 = StudyLog(
          id: '1',
          date: DateTime(2024, 1, 1),
          hours: 4.0,
        );
        final log2 = StudyLog(
          id: '2',
          date: DateTime(2024, 1, 3),
          hours: 3.5,
        );
        final log3 = StudyLog(
          id: '3',
          date: DateTime(2024, 1, 2),
          hours: 5.0,
        );

        provider.addStudyLog(log1);
        provider.addStudyLog(log2);
        provider.addStudyLog(log3);

        expect(provider.studyLogs[0].id, '2'); // Most recent
        expect(provider.studyLogs[1].id, '3');
        expect(provider.studyLogs[2].id, '1'); // Oldest
      });

      test('should remove a study log by id', () {
        final log1 = StudyLog(
          id: '1',
          date: DateTime(2024, 1, 1),
          hours: 4.0,
        );
        final log2 = StudyLog(
          id: '2',
          date: DateTime(2024, 1, 2),
          hours: 3.5,
        );

        provider.addStudyLog(log1);
        provider.addStudyLog(log2);
        provider.removeStudyLog('1');

        expect(provider.studyLogs.length, 1);
        expect(provider.studyLogs.first.id, '2');
      });

      test('should get study logs by date range', () {
        final log1 = StudyLog(
          id: '1',
          date: DateTime(2024, 1, 1),
          hours: 4.0,
        );
        final log2 = StudyLog(
          id: '2',
          date: DateTime(2024, 1, 5),
          hours: 3.5,
        );
        final log3 = StudyLog(
          id: '3',
          date: DateTime(2024, 1, 10),
          hours: 5.0,
        );

        provider.addStudyLog(log1);
        provider.addStudyLog(log2);
        provider.addStudyLog(log3);

        final filtered = provider.getStudyLogsByDateRange(
          DateTime(2024, 1, 2),
          DateTime(2024, 1, 8),
        );

        expect(filtered.length, 1);
        expect(filtered.first.id, '2');
      });

      test('should calculate average study hours', () {
        final now = DateTime.now();
        final log1 = StudyLog(
          id: '1',
          date: DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1)),
          hours: 4.0,
        );
        final log2 = StudyLog(
          id: '2',
          date: DateTime(now.year, now.month, now.day).subtract(const Duration(days: 2)),
          hours: 6.0,
        );

        provider.addStudyLog(log1);
        provider.addStudyLog(log2);

        final average = provider.getAverageStudyHours();
        expect(average, 5.0);
      });

      test('should return 0 for average when no study logs', () {
        final average = provider.getAverageStudyHours();
        expect(average, 0);
      });
    });

    group('Last 7 Days', () {
      test('should get last 7 days of sleep logs', () {
        final now = DateTime.now();
        final log1 = SleepLog(
          id: '1',
          date: DateTime(now.year, now.month, now.day).subtract(const Duration(days: 2)),
          hours: 8.0,
        );
        final log2 = SleepLog(
          id: '2',
          date: DateTime(now.year, now.month, now.day).subtract(const Duration(days: 10)),
          hours: 7.0,
        );

        provider.addSleepLog(log1);
        provider.addSleepLog(log2);

        final last7Days = provider.getLast7DaysSleep();
        expect(last7Days.length, 1);
        expect(last7Days.first.id, '1');
      });

      test('should get last 7 days of study logs', () {
        final now = DateTime.now();
        final log1 = StudyLog(
          id: '1',
          date: DateTime(now.year, now.month, now.day).subtract(const Duration(days: 3)),
          hours: 4.0,
        );
        final log2 = StudyLog(
          id: '2',
          date: DateTime(now.year, now.month, now.day).subtract(const Duration(days: 10)),
          hours: 5.0,
        );

        provider.addStudyLog(log1);
        provider.addStudyLog(log2);

        final last7Days = provider.getLast7DaysStudy();
        expect(last7Days.length, 1);
        expect(last7Days.first.id, '1');
      });
    });
  });
}
