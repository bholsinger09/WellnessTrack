import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final DateTime createdAt;
  final bool isAnonymous;

  const UserModel({
    required this.id,
    required this.email,
    this.displayName,
    required this.createdAt,
    this.isAnonymous = false,
  });

  @override
  List<Object?> get props => [id, email, displayName, createdAt, isAnonymous];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isAnonymous: json['isAnonymous'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'createdAt': createdAt.toIso8601String(),
      'isAnonymous': isAnonymous,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    DateTime? createdAt,
    bool? isAnonymous,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
      isAnonymous: isAnonymous ?? this.isAnonymous,
    );
  }
}
