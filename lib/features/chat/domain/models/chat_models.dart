class ChatMessage {
  final String id;
  final String roomId;
  final String senderId;
  final String senderDisplayName; // Anonymous display name
  final String message;
  final DateTime timestamp;
  final bool isDeleted;

  ChatMessage({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.senderDisplayName,
    required this.message,
    required this.timestamp,
    this.isDeleted = false,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      roomId: json['roomId'] as String,
      senderId: json['senderId'] as String,
      senderDisplayName: json['senderDisplayName'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'senderId': senderId,
      'senderDisplayName': senderDisplayName,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isDeleted': isDeleted,
    };
  }
}

class ChatRoom {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final List<String> participantIds;

  ChatRoom({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    required this.participantIds,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      participantIds: List<String>.from(json['participantIds'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'participantIds': participantIds,
    };
  }
}
