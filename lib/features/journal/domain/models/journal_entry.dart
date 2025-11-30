import 'package:equatable/equatable.dart';

class JournalEntry extends Equatable {
  final String id;
  final String userId;
  final String content;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? aiResponse;
  final List<String> tags;

  const JournalEntry({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    this.aiResponse,
    this.tags = const [],
  });

  @override
  List<Object?> get props => [id, userId, content, createdAt, updatedAt, aiResponse, tags];

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      aiResponse: json['aiResponse'] as String?,
      tags: List<String>.from(json['tags'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'aiResponse': aiResponse,
      'tags': tags,
    };
  }

  JournalEntry copyWith({
    String? id,
    String? userId,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? aiResponse,
    List<String>? tags,
  }) {
    return JournalEntry(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      aiResponse: aiResponse ?? this.aiResponse,
      tags: tags ?? this.tags,
    );
  }
}
