import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../../core/routes/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.signOut();
              if (context.mounted) {
                context.go(AppRouter.login);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, ${user?.displayName ?? 'Student'}!',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'How are you feeling today?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Your Wellness Tools',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _FeatureCard(
                  icon: Icons.mood,
                  title: 'Mood Check-In',
                  color: const Color(0xFFFF6B9D),
                  onTap: () => context.push(AppRouter.moodCheckIn),
                ),
                _FeatureCard(
                  icon: Icons.history,
                  title: 'Mood History',
                  color: const Color(0xFFFF8C94),
                  onTap: () => context.push(AppRouter.moodHistory),
                ),
                _FeatureCard(
                  icon: Icons.nightlight_round,
                  title: 'Sleep & Study',
                  color: const Color(0xFF6B4CE6),
                  onTap: () => context.push(AppRouter.sleepStudy),
                ),
                _FeatureCard(
                  icon: Icons.self_improvement,
                  title: 'Meditation',
                  color: const Color(0xFF50C878),
                  onTap: () => context.push(AppRouter.meditation),
                ),
                _FeatureCard(
                  icon: Icons.chat_bubble_outline,
                  title: 'Peer Support',
                  color: const Color(0xFF4ECDC4),
                  onTap: () => context.push(AppRouter.chat),
                ),
                _FeatureCard(
                  icon: Icons.book,
                  title: 'AI Journal',
                  color: const Color(0xFFFFBE0B),
                  onTap: () => context.push(AppRouter.journal),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
