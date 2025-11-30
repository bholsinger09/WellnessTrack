import 'package:equatable/equatable.dart';

class StudyLog extends Equatable {
  final String id;
  final DateTime date;
  final double hours;
  final String? subject;
  final String? notes;

  const StudyLog({
    required this.id,
    required this.date,
    required this.hours,
    this.subject,
    this.notes,
  });

  @override
  List<Object?> get props => [id, date, hours, subject, notes];

  StudyLog copyWith({
    String? id,
    DateTime? date,
    double? hours,
    String? subject,
    String? notes,
  }) {
    return StudyLog(
      id: id ?? this.id,
      date: date ?? this.date,
      hours: hours ?? this.hours,
      subject: subject ?? this.subject,
      notes: notes ?? this.notes,
    );
  }
}
