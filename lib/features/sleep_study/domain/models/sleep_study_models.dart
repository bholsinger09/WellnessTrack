class SleepLog {
  final String id;
  final String userId;
  final DateTime date;
  final double hoursSlept;
  final int sleepQuality; // 1-5 rating
  final String? notes;

  SleepLog({
    required this.id,
    required this.userId,
    required this.date,
    required this.hoursSlept,
    required this.sleepQuality,
    this.notes,
  });

  factory SleepLog.fromJson(Map<String, dynamic> json) {
    return SleepLog(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      hoursSlept: (json['hoursSlept'] as num).toDouble(),
      sleepQuality: json['sleepQuality'] as int,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'hoursSlept': hoursSlept,
      'sleepQuality': sleepQuality,
      'notes': notes,
    };
  }
}

class StudyLog {
  final String id;
  final String userId;
  final DateTime date;
  final double hoursStudied;
  final String? subject;
  final int productivity; // 1-5 rating
  final String? notes;

  StudyLog({
    required this.id,
    required this.userId,
    required this.date,
    required this.hoursStudied,
    this.subject,
    required this.productivity,
    this.notes,
  });

  factory StudyLog.fromJson(Map<String, dynamic> json) {
    return StudyLog(
      id: json['id'] as String,
      userId: json['userId'] as String,
      date: DateTime.parse(json['date'] as String),
      hoursStudied: (json['hoursStudied'] as num).toDouble(),
      subject: json['subject'] as String?,
      productivity: json['productivity'] as int,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'date': date.toIso8601String(),
      'hoursStudied': hoursStudied,
      'subject': subject,
      'productivity': productivity,
      'notes': notes,
    };
  }
}
