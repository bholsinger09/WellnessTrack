import 'package:flutter_test/flutter_test.dart';
import 'package:wellness_tracker/features/auth/domain/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('should create a valid UserModel', () {
      final user = UserModel(
        id: '123',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: DateTime(2024, 1, 1),
        isAnonymous: false,
      );

      expect(user.id, '123');
      expect(user.email, 'test@example.com');
      expect(user.displayName, 'Test User');
      expect(user.isAnonymous, false);
    });

    test('should convert to JSON correctly', () {
      final user = UserModel(
        id: '123',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: DateTime(2024, 1, 1),
        isAnonymous: false,
      );

      final json = user.toJson();

      expect(json['id'], '123');
      expect(json['email'], 'test@example.com');
      expect(json['displayName'], 'Test User');
      expect(json['isAnonymous'], false);
    });

    test('should create from JSON correctly', () {
      final json = {
        'id': '123',
        'email': 'test@example.com',
        'displayName': 'Test User',
        'createdAt': '2024-01-01T00:00:00.000',
        'isAnonymous': false,
      };

      final user = UserModel.fromJson(json);

      expect(user.id, '123');
      expect(user.email, 'test@example.com');
      expect(user.displayName, 'Test User');
      expect(user.isAnonymous, false);
    });

    test('should handle null displayName', () {
      final user = UserModel(
        id: '123',
        email: 'test@example.com',
        createdAt: DateTime(2024, 1, 1),
        isAnonymous: false,
      );

      expect(user.displayName, null);
    });

    test('copyWith should create a new instance with updated values', () {
      final user = UserModel(
        id: '123',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: DateTime(2024, 1, 1),
        isAnonymous: false,
      );

      final updatedUser = user.copyWith(displayName: 'Updated Name');

      expect(updatedUser.displayName, 'Updated Name');
      expect(updatedUser.id, user.id);
      expect(updatedUser.email, user.email);
    });
  });
}
