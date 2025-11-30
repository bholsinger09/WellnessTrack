import 'package:equatable/equatable.dart';

class SleepLog extends Equatable {
  final String id;
  final DateTime date;
  final double hours;
  final DateTime? bedTime;
  final DateTime? wakeTime;
  final String? notes;

  const SleepLog({
    required this.id,
    required this.date,
    required this.hours,
    this.bedTime,
    this.wakeTime,
    this.notes,
  });

  @override
  List<Object?> get props => [id, date, hours, bedTime, wakeTime, notes];

  SleepLog copyWith({
    String? id,
    DateTime? date,
    double? hours,
    DateTime? bedTime,
    DateTime? wakeTime,
    String? notes,
  }) {
    return SleepLog(
      id: id ?? this.id,
      date: date ?? this.date,
      hours: hours ?? this.hours,
      bedTime: bedTime ?? this.bedTime,
      wakeTime: wakeTime ?? this.wakeTime,
      notes: notes ?? this.notes,
    );
  }
}
