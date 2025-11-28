import 'package:flutter/foundation.dart';
import '../../domain/models/mood_log.dart';

class MoodProvider extends ChangeNotifier {
  final List<MoodLog> _moodLogs = [];

  List<MoodLog> get moodLogs => List.unmodifiable(_moodLogs);

  void addMoodLog(MoodLog moodLog) {
    _moodLogs.insert(0, moodLog); // Add to beginning for newest first
    notifyListeners();
  }

  void removeMoodLog(String id) {
    _moodLogs.removeWhere((log) => log.id == id);
    notifyListeners();
  }

  List<MoodLog> getMoodLogsByDateRange(DateTime start, DateTime end) {
    return _moodLogs
        .where((log) =>
            log.timestamp.isAfter(start) && log.timestamp.isBefore(end))
        .toList();
  }
}
