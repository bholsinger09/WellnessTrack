import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/mood_tracking/presentation/screens/mood_check_in_screen.dart';
import '../../features/mood_tracking/presentation/screens/mood_history_screen.dart';
import '../../features/sleep_study/presentation/screens/sleep_study_screen.dart';
import '../../features/meditation/presentation/screens/meditation_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/journal/presentation/screens/journal_screen.dart';

class AppRouter {
  static const String login = '/';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String moodCheckIn = '/mood-check-in';
  static const String moodHistory = '/mood-history';
  static const String sleepStudy = '/sleep-study';
  static const String meditation = '/meditation';
  static const String chat = '/chat';
  static const String journal = '/journal';

  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: moodCheckIn,
        builder: (context, state) => const MoodCheckInScreen(),
      ),
      GoRoute(
        path: moodHistory,
        builder: (context, state) => const MoodHistoryScreen(),
      ),
      GoRoute(
        path: sleepStudy,
        builder: (context, state) => const SleepStudyScreen(),
      ),
      GoRoute(
        path: meditation,
        builder: (context, state) => const MeditationScreen(),
      ),
      GoRoute(
        path: chat,
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: journal,
        builder: (context, state) => const JournalScreen(),
      ),
    ],
  );
}
