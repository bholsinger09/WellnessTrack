enum MoodType {
  veryHappy,
  happy,
  neutral,
  sad,
  verySad,
}

class MoodLog {
  final String id;
  final String userId;
  final MoodType mood;
  final String? notes;
  final DateTime timestamp;

  MoodLog({
    required this.id,
    required this.userId,
    required this.mood,
    this.notes,
    required this.timestamp,
  });

  factory MoodLog.fromJson(Map<String, dynamic> json) {
    return MoodLog(
      id: json['id'] as String,
      userId: json['userId'] as String,
      mood: MoodType.values.firstWhere(
        (e) => e.toString() == 'MoodType.${json['mood']}',
        orElse: () => MoodType.neutral,
      ),
      notes: json['notes'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'mood': mood.toString().split('.').last,
      'notes': notes,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  String get moodEmoji {
    switch (mood) {
      case MoodType.veryHappy:
        return '😄';
      case MoodType.happy:
        return '🙂';
      case MoodType.neutral:
        return '😐';
      case MoodType.sad:
        return '😔';
      case MoodType.verySad:
        return '😢';
    }
  }

  String get moodLabel {
    switch (mood) {
      case MoodType.veryHappy:
        return 'Very Happy';
      case MoodType.happy:
        return 'Happy';
      case MoodType.neutral:
        return 'Neutral';
      case MoodType.sad:
        return 'Sad';
      case MoodType.verySad:
        return 'Very Sad';
    }
  }
}
