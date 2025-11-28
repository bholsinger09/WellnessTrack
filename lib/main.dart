// import 'dart:io' show Platform;
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
// import 'firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/mood_tracking/presentation/providers/mood_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase temporarily disabled - using mock auth for development
  // Initialize Firebase (skip on macOS for now due to BoringSSL-GRPC build issue)
  // if (!kIsWeb && !Platform.isMacOS) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }
  
  runApp(const WellnessTrackerApp());
}

class WellnessTrackerApp extends StatelessWidget {
  const WellnessTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MoodProvider()),
      ],
      child: MaterialApp.router(
        title: 'Wellness Tracker',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
