import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Clean Architecture Structure Tests', () {
    final libDir = Directory('lib');

    test('should have proper feature-based folder structure', () {
      expect(libDir.existsSync(), true, reason: 'lib directory should exist');

      final features = [
        'auth',
        'mood_tracking',
        'sleep_study',
        'meditation',
        'chat',
        'journal',
        'home',
      ];

      for (final feature in features) {
        final featureDir = Directory('lib/features/$feature');
        expect(
          featureDir.existsSync(),
          true,
          reason: 'Feature directory $feature should exist',
        );
      }
    });

    test('should have core folder with shared components', () {
      final coreDir = Directory('lib/core');
      expect(coreDir.existsSync(), true, reason: 'core directory should exist');

      final coreComponents = [
        'theme',
        'routes',
        'widgets',
        'providers',
      ];

      for (final component in coreComponents) {
        final componentDir = Directory('lib/core/$component');
        expect(
          componentDir.existsSync(),
          true,
          reason: 'Core component $component should exist',
        );
      }
    });

    test('should follow clean architecture layers in features', () {
      final features = ['mood_tracking', 'sleep_study', 'auth'];

      for (final feature in features) {
        final layers = ['domain', 'presentation'];
        
        for (final layer in layers) {
          final layerDir = Directory('lib/features/$feature/$layer');
          expect(
            layerDir.existsSync(),
            true,
            reason: 'Feature $feature should have $layer layer',
          );
        }
      }
    });

    test('domain layer should contain entities or models', () {
      final features = ['mood_tracking', 'sleep_study', 'auth'];

      for (final feature in features) {
        final domainDir = Directory('lib/features/$feature/domain');
        if (domainDir.existsSync()) {
          final hasModels = Directory('lib/features/$feature/domain/models').existsSync();
          final hasEntities = Directory('lib/features/$feature/domain/entities').existsSync();
          
          expect(
            hasModels || hasEntities,
            true,
            reason: 'Feature $feature domain layer should have models or entities',
          );
        }
      }
    });

    test('presentation layer should contain providers and screens', () {
      final features = ['mood_tracking', 'sleep_study', 'home', 'auth'];

      for (final feature in features) {
        final presentationDir = Directory('lib/features/$feature/presentation');
        if (presentationDir.existsSync()) {
          final hasProviders = Directory('lib/features/$feature/presentation/providers').existsSync();
          final hasScreens = Directory('lib/features/$feature/presentation/screens').existsSync();
          
          expect(
            hasProviders || hasScreens,
            true,
            reason: 'Feature $feature presentation should have providers or screens',
          );
        }
      }
    });

    test('should have test directory mirroring lib structure', () {
      final testDir = Directory('test');
      expect(testDir.existsSync(), true, reason: 'test directory should exist');

      final testFeatures = Directory('test/features');
      expect(
        testFeatures.existsSync(),
        true,
        reason: 'test/features should mirror lib/features',
      );
    });

    test('each feature with domain models should have corresponding tests', () {
      final features = ['mood_tracking', 'sleep_study', 'auth'];

      for (final feature in features) {
        final domainDir = Directory('lib/features/$feature/domain');
        if (domainDir.existsSync()) {
          final testDomainDir = Directory('test/features/$feature/domain');
          expect(
            testDomainDir.existsSync(),
            true,
            reason: 'Feature $feature should have domain tests',
          );
        }
      }
    });

    test('provider files should follow naming convention', () {
      final providerFiles = _findFilesRecursively(
        Directory('lib'),
        pattern: '_provider.dart',
      );

      for (final file in providerFiles) {
        final content = file.readAsStringSync();
        
        // Check that provider files extend ChangeNotifier
        expect(
          content.contains('ChangeNotifier') || content.contains('extends'),
          true,
          reason: '${file.path} should contain ChangeNotifier or extend something',
        );
      }
    });

    test('screen files should follow naming convention', () {
      final screenFiles = _findFilesRecursively(
        Directory('lib/features'),
        pattern: '_screen.dart',
      );

      expect(
        screenFiles.length,
        greaterThan(0),
        reason: 'Should have screen files ending with _screen.dart',
      );

      for (final file in screenFiles) {
        final content = file.readAsStringSync();
        
        // Check that screen files contain StatelessWidget or StatefulWidget
        expect(
          content.contains('StatelessWidget') || content.contains('StatefulWidget'),
          true,
          reason: '${file.path} should contain a Widget class',
        );
      }
    });

    test('model/entity files should use equatable for value equality', () {
      final modelFiles = [
        ..._findFilesRecursively(Directory('lib/features'), pattern: 'domain/models'),
        ..._findFilesRecursively(Directory('lib/features'), pattern: 'domain/entities'),
      ];

      for (final file in modelFiles) {
        if (file.path.endsWith('.dart') && !file.path.contains('test')) {
          final content = file.readAsStringSync();
          
          // Check that domain models use Equatable
          if (content.contains('class ') && !content.contains('enum ')) {
            expect(
              content.contains('Equatable') || content.contains('==') || content.contains('hashCode'),
              true,
              reason: '${file.path} should implement equality (Equatable or override == and hashCode)',
            );
          }
        }
      }
    });

    test('no business logic in presentation layer', () {
      final screenFiles = _findFilesRecursively(
        Directory('lib/features'),
        pattern: '_screen.dart',
      );

      for (final file in screenFiles) {
        final content = file.readAsStringSync();
        
        // Screens should use providers, not contain direct data manipulation
        final hasDatabaseCalls = content.contains('database') || 
                                 content.contains('firestore') ||
                                 content.contains('FirebaseFirestore');
        
        expect(
          hasDatabaseCalls,
          false,
          reason: '${file.path} should not contain direct database calls',
        );
      }
    });

    test('providers should call notifyListeners after state changes', () {
      final providerFiles = _findFilesRecursively(
        Directory('lib'),
        pattern: '_provider.dart',
      );

      for (final file in providerFiles) {
        final content = file.readAsStringSync();
        
        if (content.contains('ChangeNotifier')) {
          // If there are methods that modify state, they should notify listeners
          final hasStateMutation = content.contains('.add(') || 
                                   content.contains('.remove(') ||
                                   content.contains('_') && content.contains(' = ');
          
          if (hasStateMutation) {
            expect(
              content.contains('notifyListeners'),
              true,
              reason: '${file.path} should call notifyListeners after state changes',
            );
          }
        }
      }
    });

    test('test files should have corresponding source files', () {
      final testFiles = _findFilesRecursively(
        Directory('test'),
        pattern: '_test.dart',
      );

      for (final testFile in testFiles) {
        final testPath = testFile.path;
        // Skip widget tests and architecture tests (these are meta-tests)
        if (testPath.contains('widget_test.dart') || 
            testPath.contains('architecture/')) continue;
        
        // Convert test path to source path
        final sourcePath = testPath
            .replaceAll('test/', 'lib/')
            .replaceAll('_test.dart', '.dart');
        
        final sourceFile = File(sourcePath);
        expect(
          sourceFile.existsSync(),
          true,
          reason: 'Test file $testPath should have corresponding source file $sourcePath',
        );
      }
    });

    test('main.dart should not contain business logic', () {
      final mainFile = File('lib/main.dart');
      expect(mainFile.existsSync(), true, reason: 'main.dart should exist');

      final content = mainFile.readAsStringSync();
      
      // main.dart should only setup app, not contain business logic
      expect(
        content.contains('runApp'),
        true,
        reason: 'main.dart should contain runApp',
      );

      expect(
        content.split('\n').length,
        lessThan(100),
        reason: 'main.dart should be concise (< 100 lines)',
      );
    });

    test('routes should be centralized in app_router', () {
      final routerFile = File('lib/core/routes/app_router.dart');
      expect(routerFile.existsSync(), true, reason: 'app_router.dart should exist');

      final content = routerFile.readAsStringSync();
      expect(
        content.contains('GoRouter') || content.contains('routes'),
        true,
        reason: 'app_router should define routes',
      );
    });

    test('theme should be centralized in app_theme', () {
      final themeFile = File('lib/core/theme/app_theme.dart');
      expect(themeFile.existsSync(), true, reason: 'app_theme.dart should exist');

      final content = themeFile.readAsStringSync();
      expect(
        content.contains('ThemeData') || content.contains('lightTheme') || content.contains('darkTheme'),
        true,
        reason: 'app_theme should define ThemeData',
      );
    });
  });

  group('Code Quality Tests', () {
    test('no TODO comments in production code', () {
      final dartFiles = _findFilesRecursively(
        Directory('lib'),
        pattern: '.dart',
      );

      final filesWithTodo = <String>[];
      for (final file in dartFiles) {
        final content = file.readAsStringSync();
        if (content.contains('TODO') || content.contains('FIXME')) {
          filesWithTodo.add(file.path);
        }
      }

      expect(
        filesWithTodo,
        isEmpty,
        reason: 'Production code should not contain TODO/FIXME comments: $filesWithTodo',
      );
    });

    test('no print statements in production code', () {
      final dartFiles = _findFilesRecursively(
        Directory('lib'),
        pattern: '.dart',
      );

      final filesWithPrint = <String>[];
      for (final file in dartFiles) {
        final content = file.readAsStringSync();
        // Allow print in debug builds but flag standalone prints
        if (content.contains('print(') && !content.contains('kDebugMode')) {
          filesWithPrint.add(file.path);
        }
      }

      expect(
        filesWithPrint,
        isEmpty,
        reason: 'Production code should not contain print statements (use proper logging): $filesWithPrint',
      );
    });

    test('files should not be too large', () {
      final dartFiles = _findFilesRecursively(
        Directory('lib'),
        pattern: '.dart',
      );

      final largeFiles = <String>[];
      for (final file in dartFiles) {
        final lines = file.readAsLinesSync().length;
        // Allow up to 800 lines for complex screens with multiple views
        // (Screens with tabs and multiple sections may be larger)
        if (lines > 800) {
          largeFiles.add('${file.path} ($lines lines)');
        }
      }

      expect(
        largeFiles,
        isEmpty,
        reason: 'Files should be under 800 lines (consider splitting): $largeFiles',
      );
    });
  });
}

List<File> _findFilesRecursively(Directory dir, {required String pattern}) {
  final files = <File>[];
  
  if (!dir.existsSync()) return files;

  for (final entity in dir.listSync(recursive: true)) {
    if (entity is File && entity.path.contains(pattern)) {
      files.add(entity);
    }
  }

  return files;
}
