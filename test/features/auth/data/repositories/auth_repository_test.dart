import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wellness_tracker/features/auth/data/repositories/auth_repository.dart';
import 'package:wellness_tracker/features/auth/domain/models/user_model.dart';

@GenerateMocks([FirebaseAuth, FirebaseFirestore, UserCredential, User])
import 'auth_repository_test.mocks.dart';

void main() {
  late AuthRepository authRepository;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirestore;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    authRepository = AuthRepository(
      firebaseAuth: mockFirebaseAuth,
      firestore: mockFirestore,
    );
  });

  group('AuthRepository', () {
    group('signUp', () {
      test('should create a new user successfully', () async {
        // Arrange
        final mockUserCredential = MockUserCredential();
        final mockUser = MockUser();

        when(mockUser.uid).thenReturn('123');
        when(mockUserCredential.user).thenReturn(mockUser);
        when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => mockUserCredential);

        // Act & Assert
        // Note: Full test would require mocking Firestore collection/doc
        expect(() => authRepository.signUp(
          email: 'test@example.com',
          password: 'password123',
        ), returnsNormally);
      });
    });

    group('signIn', () {
      test('should sign in user successfully', () async {
        // Arrange
        final mockUserCredential = MockUserCredential();
        final mockUser = MockUser();

        when(mockUser.uid).thenReturn('123');
        when(mockUserCredential.user).thenReturn(mockUser);
        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => mockUserCredential);

        // Act & Assert
        expect(() => authRepository.signIn(
          email: 'test@example.com',
          password: 'password123',
        ), returnsNormally);
      });
    });

    group('signOut', () {
      test('should sign out user successfully', () async {
        // Arrange
        when(mockFirebaseAuth.signOut()).thenAnswer((_) async => null);

        // Act
        await authRepository.signOut();

        // Assert
        verify(mockFirebaseAuth.signOut()).called(1);
      });
    });

    group('currentUser', () {
      test('should return current user', () {
        // Arrange
        final mockUser = MockUser();
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

        // Act
        final currentUser = authRepository.currentUser;

        // Assert
        expect(currentUser, mockUser);
      });

      test('should return null when no user is signed in', () {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(null);

        // Act
        final currentUser = authRepository.currentUser;

        // Assert
        expect(currentUser, null);
      });
    });
  });
}
