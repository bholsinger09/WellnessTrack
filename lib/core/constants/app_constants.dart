class AppConstants {
  // App Info
  static const String appName = 'Wellness Tracker';
  static const String appVersion = '1.0.0';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String moodLogsCollection = 'mood_logs';
  static const String sleepLogsCollection = 'sleep_logs';
  static const String studyLogsCollection = 'study_logs';
  static const String meditationSessionsCollection = 'meditation_sessions';
  static const String journalEntriesCollection = 'journal_entries';
  static const String chatRoomsCollection = 'chat_rooms';
  
  // Shared Preferences Keys
  static const String keyUserId = 'user_id';
  static const String keyUserEmail = 'user_email';
  static const String keyThemeMode = 'theme_mode';
  
  // Mood Types
  static const List<String> moodTypes = [
    'Very Happy',
    'Happy',
    'Neutral',
    'Sad',
    'Very Sad',
  ];
  
  // Meditation Presets (in minutes)
  static const List<int> meditationPresets = [5, 10, 15, 20, 30];
  
  // Error Messages
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'Network error. Please check your connection.';
  static const String errorAuth = 'Authentication failed. Please try again.';
}
