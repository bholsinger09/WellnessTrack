import 'package:flutter/material.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final _contentController = TextEditingController();
  bool _isLoadingAI = false;
  String? _aiResponse;

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _getAIInsights() async {
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write something first')),
      );
      return;
    }

    setState(() {
      _isLoadingAI = true;
    });

    // Simulate AI response
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _aiResponse = 'Thank you for sharing your thoughts. It sounds like you\'re '
          'experiencing some stress. Remember to take breaks, practice self-care, '
          'and reach out for support when needed. You\'re doing great! 💙';
      _isLoadingAI = false;
    });
  }

  void _saveEntry() {
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please write something first')),
      );
      return;
    }

    // Save functionality will be implemented with backend integration
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Journal entry saved!')),
    );

    setState(() {
      _contentController.clear();
      _aiResponse = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Journal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Journal history coming soon')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'AI-Powered Journaling',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Write about your day and get personalized insights from our AI assistant.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'What\'s on your mind?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: 'Start writing your journal entry...',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 10,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _isLoadingAI ? null : _getAIInsights,
                    icon: _isLoadingAI
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.psychology),
                    label: Text(_isLoadingAI ? 'Analyzing...' : 'Get AI Insights'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _saveEntry,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Entry'),
                  ),
                ),
              ],
            ),
            if (_aiResponse != null) ...[
              const SizedBox(height: 24),
              Card(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'AI Insights',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(_aiResponse!),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            Text(
              'Recent Entries',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _RecentEntryCard(
              date: 'Today',
              preview: 'Had a great study session today...',
              mood: '😊',
            ),
            _RecentEntryCard(
              date: 'Yesterday',
              preview: 'Feeling a bit overwhelmed with assignments...',
              mood: '😔',
            ),
            _RecentEntryCard(
              date: '2 days ago',
              preview: 'Meditation really helped me relax...',
              mood: '😌',
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentEntryCard extends StatelessWidget {
  final String date;
  final String preview;
  final String mood;

  const _RecentEntryCard({
    required this.date,
    required this.preview,
    required this.mood,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Text(
          mood,
          style: const TextStyle(fontSize: 32),
        ),
        title: Text(date),
        subtitle: Text(
          preview,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Entry detail view to be implemented
        },
      ),
    );
  }
}
