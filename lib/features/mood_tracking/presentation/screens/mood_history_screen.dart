import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../domain/models/mood_log.dart';
import '../providers/mood_provider.dart';

class MoodHistoryScreen extends StatelessWidget {
  const MoodHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moodLogs = context.watch<MoodProvider>().moodLogs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood History'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: moodLogs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.mood_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No mood check-ins yet',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start tracking your mood to see your history',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: moodLogs.length,
              itemBuilder: (context, index) {
                final moodLog = moodLogs[index];
                final formattedDate = _formatDate(moodLog.timestamp);
                
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: _getMoodIcon(moodLog.mood),
                    title: Text(
                      _getMoodLabel(moodLog.mood),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(formattedDate),
                        if (moodLog.notes != null && moodLog.notes!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            moodLog.notes!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _formatDate(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCheck = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (dateToCheck == today) {
      return 'Today, ${DateFormat('h:mm a').format(timestamp)}';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday, ${DateFormat('h:mm a').format(timestamp)}';
    } else {
      return DateFormat('MMM d, h:mm a').format(timestamp);
    }
  }

  String _getMoodLabel(MoodType mood) {
    switch (mood) {
      case MoodType.veryHappy:
        return 'Very Happy';
      case MoodType.happy:
        return 'Happy';
      case MoodType.neutral:
        return 'Neutral';
      case MoodType.sad:
        return 'Sad';
      case MoodType.verySad:
        return 'Very Sad';
    }
  }

  Widget _getMoodIcon(MoodType mood) {
    IconData icon;
    Color color;

    switch (mood) {
      case MoodType.veryHappy:
        icon = Icons.sentiment_very_satisfied;
        color = const Color(0xFF50C878);
        break;
      case MoodType.happy:
        icon = Icons.sentiment_satisfied;
        color = const Color(0xFF8ED973);
        break;
      case MoodType.neutral:
        icon = Icons.sentiment_neutral;
        color = const Color(0xFFFFBE0B);
        break;
      case MoodType.sad:
        icon = Icons.sentiment_dissatisfied;
        color = const Color(0xFFFF8C94);
        break;
      case MoodType.verySad:
        icon = Icons.sentiment_very_dissatisfied;
        color = const Color(0xFFFF6B9D);
        break;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 32),
    );
  }
}
