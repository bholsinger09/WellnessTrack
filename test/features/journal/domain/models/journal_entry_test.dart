import 'package:flutter_test/flutter_test.dart';
import 'package:wellness_tracker/features/journal/domain/models/journal_entry.dart';

void main() {
  group('JournalEntry', () {
    test('should create a valid JournalEntry', () {
      final entry = JournalEntry(
        id: '123',
        userId: 'user123',
        content: 'Today was a good day',
        createdAt: DateTime(2024, 1, 1),
        tags: ['wellness', 'happy'],
      );

      expect(entry.id, '123');
      expect(entry.userId, 'user123');
      expect(entry.content, 'Today was a good day');
      expect(entry.tags.length, 2);
    });

    test('should convert to JSON correctly', () {
      final entry = JournalEntry(
        id: '123',
        userId: 'user123',
        content: 'Today was a good day',
        createdAt: DateTime(2024, 1, 1),
        aiResponse: 'That sounds wonderful!',
        tags: ['wellness'],
      );

      final json = entry.toJson();

      expect(json['id'], '123');
      expect(json['content'], 'Today was a good day');
      expect(json['aiResponse'], 'That sounds wonderful!');
      expect(json['tags'], ['wellness']);
    });

    test('should create from JSON correctly', () {
      final json = {
        'id': '123',
        'userId': 'user123',
        'content': 'Today was a good day',
        'createdAt': '2024-01-01T00:00:00.000',
        'aiResponse': 'That sounds wonderful!',
        'tags': ['wellness', 'happy'],
      };

      final entry = JournalEntry.fromJson(json);

      expect(entry.id, '123');
      expect(entry.content, 'Today was a good day');
      expect(entry.aiResponse, 'That sounds wonderful!');
      expect(entry.tags.length, 2);
    });

    test('copyWith should create a new instance with updated values', () {
      final entry = JournalEntry(
        id: '123',
        userId: 'user123',
        content: 'Original content',
        createdAt: DateTime(2024, 1, 1),
      );

      final updatedEntry = entry.copyWith(
        content: 'Updated content',
        aiResponse: 'New AI response',
      );

      expect(updatedEntry.content, 'Updated content');
      expect(updatedEntry.aiResponse, 'New AI response');
      expect(updatedEntry.id, entry.id);
      expect(updatedEntry.userId, entry.userId);
    });

    test('should handle empty tags list', () {
      final entry = JournalEntry(
        id: '123',
        userId: 'user123',
        content: 'Content',
        createdAt: DateTime.now(),
      );

      expect(entry.tags, []);
    });

    test('should handle null aiResponse', () {
      final entry = JournalEntry(
        id: '123',
        userId: 'user123',
        content: 'Content',
        createdAt: DateTime.now(),
      );

      expect(entry.aiResponse, null);
    });
  });
}
