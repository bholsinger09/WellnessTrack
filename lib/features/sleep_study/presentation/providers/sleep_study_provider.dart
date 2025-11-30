import 'package:flutter/foundation.dart';
import '../../domain/entities/sleep_log.dart';
import '../../domain/entities/study_log.dart';

class SleepStudyProvider with ChangeNotifier {
  final List<SleepLog> _sleepLogs = [];
  final List<StudyLog> _studyLogs = [];

  List<SleepLog> get sleepLogs => List.unmodifiable(_sleepLogs);
  List<StudyLog> get studyLogs => List.unmodifiable(_studyLogs);

  // Add a sleep log
  void addSleepLog(SleepLog log) {
    _sleepLogs.add(log);
    _sleepLogs.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  // Add a study log
  void addStudyLog(StudyLog log) {
    _studyLogs.add(log);
    _studyLogs.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  // Remove a sleep log
  void removeSleepLog(String id) {
    _sleepLogs.removeWhere((log) => log.id == id);
    notifyListeners();
  }

  // Remove a study log
  void removeStudyLog(String id) {
    _studyLogs.removeWhere((log) => log.id == id);
    notifyListeners();
  }

  // Get sleep logs for a date range
  List<SleepLog> getSleepLogsByDateRange(DateTime start, DateTime end) {
    return _sleepLogs.where((log) {
      return log.date.isAfter(start.subtract(const Duration(days: 1))) &&
          log.date.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }

  // Get study logs for a date range
  List<StudyLog> getStudyLogsByDateRange(DateTime start, DateTime end) {
    return _studyLogs.where((log) {
      return log.date.isAfter(start.subtract(const Duration(days: 1))) &&
          log.date.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }

  // Get last 7 days of sleep data for chart
  List<SleepLog> getLast7DaysSleep() {
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6));
    return getSleepLogsByDateRange(startDate, now);
  }

  // Get last 7 days of study data for chart
  List<StudyLog> getLast7DaysStudy() {
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6));
    return getStudyLogsByDateRange(startDate, now);
  }

  // Calculate average sleep hours
  double getAverageSleepHours({int days = 7}) {
    final logs = getLast7DaysSleep();
    if (logs.isEmpty) return 0;
    final total = logs.fold<double>(0, (sum, log) => sum + log.hours);
    return total / logs.length;
  }

  // Calculate average study hours
  double getAverageStudyHours({int days = 7}) {
    final logs = getLast7DaysStudy();
    if (logs.isEmpty) return 0;
    final total = logs.fold<double>(0, (sum, log) => sum + log.hours);
    return total / logs.length;
  }
}
