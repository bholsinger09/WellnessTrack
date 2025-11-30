import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/sleep_study_provider.dart';
import '../../domain/entities/sleep_log.dart';
import '../../domain/entities/study_log.dart';

class SleepStudyScreen extends StatefulWidget {
  const SleepStudyScreen({Key? key}) : super(key: key);

  @override
  State<SleepStudyScreen> createState() => _SleepStudyScreenState();
}

class _SleepStudyScreenState extends State<SleepStudyScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SleepStudyProvider>();
    final hasSleepData = provider.sleepLogs.isNotEmpty;
    final hasStudyData = provider.studyLogs.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep & Study Balance'),
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).cardColor,
            child: Row(
              children: [
                Expanded(
                  child: _TabButton(
                    label: 'Overview',
                    isSelected: _selectedTab == 0,
                    onTap: () => setState(() => _selectedTab = 0),
                  ),
                ),
                Expanded(
                  child: _TabButton(
                    label: 'Sleep',
                    isSelected: _selectedTab == 1,
                    onTap: () => setState(() => _selectedTab = 1),
                  ),
                ),
                Expanded(
                  child: _TabButton(
                    label: 'Study',
                    isSelected: _selectedTab == 2,
                    onTap: () => setState(() => _selectedTab = 2),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _selectedTab == 0
                ? _buildOverviewView(provider, hasSleepData, hasStudyData)
                : _selectedTab == 1
                    ? _buildSleepView(provider, hasSleepData)
                    : _buildStudyView(provider, hasStudyData),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddLogDialog(_selectedTab),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildOverviewView(
      SleepStudyProvider provider, bool hasSleepData, bool hasStudyData) {
    if (!hasSleepData && !hasStudyData) {
      return _buildEmptyState(
        icon: Icons.bar_chart,
        title: 'No Data Yet',
        message: 'Start tracking your sleep and study hours to see insights',
      );
    }

    final sleepLogs = provider.getLast7DaysSleep();
    final studyLogs = provider.getLast7DaysStudy();
    final avgSleep = provider.getAverageSleepHours();
    final avgStudy = provider.getAverageStudyHours();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.nightlight_round,
                  label: 'Avg Sleep',
                  value: '${avgSleep.toStringAsFixed(1)}h',
                  color: const Color(0xFF6B4CE6),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.menu_book,
                  label: 'Avg Study',
                  value: '${avgStudy.toStringAsFixed(1)}h',
                  color: const Color(0xFF50C878),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '7-Day Trend',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: _buildChart(sleepLogs, studyLogs),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendItem(
                color: const Color(0xFF6B4CE6),
                label: 'Sleep',
              ),
              const SizedBox(width: 24),
              _LegendItem(
                color: const Color(0xFF50C878),
                label: 'Study',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChart(List<SleepLog> sleepLogs, List<StudyLog> studyLogs) {
    // Create data for last 7 days
    final now = DateTime.now();
    final sleepSpots = <FlSpot>[];
    final studySpots = <FlSpot>[];

    for (int i = 0; i < 7; i++) {
      final date = DateTime(now.year, now.month, now.day).subtract(Duration(days: 6 - i));
      
      final sleepLog = sleepLogs.where((log) {
        final logDate = DateTime(log.date.year, log.date.month, log.date.day);
        return logDate.isAtSameMomentAs(date);
      }).firstOrNull;
      
      final studyLog = studyLogs.where((log) {
        final logDate = DateTime(log.date.year, log.date.month, log.date.day);
        return logDate.isAtSameMomentAs(date);
      }).firstOrNull;

      if (sleepLog != null) {
        sleepSpots.add(FlSpot(i.toDouble(), sleepLog.hours));
      }
      if (studyLog != null) {
        studySpots.add(FlSpot(i.toDouble(), studyLog.hours));
      }
    }

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text('${value.toInt()}h', style: const TextStyle(fontSize: 12));
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < 0 || value.toInt() >= 7) return const Text('');
                final date = DateTime.now().subtract(Duration(days: 6 - value.toInt()));
                return Text(
                  DateFormat('E').format(date).substring(0, 1),
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          if (sleepSpots.isNotEmpty)
            LineChartBarData(
              spots: sleepSpots,
              isCurved: true,
              color: const Color(0xFF6B4CE6),
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
          if (studySpots.isNotEmpty)
            LineChartBarData(
              spots: studySpots,
              isCurved: true,
              color: const Color(0xFF50C878),
              barWidth: 3,
              dotData: const FlDotData(show: true),
            ),
        ],
        minY: 0,
        maxY: 12,
      ),
    );
  }

  Widget _buildSleepView(SleepStudyProvider provider, bool hasData) {
    if (!hasData) {
      return _buildEmptyState(
        icon: Icons.nightlight_round,
        title: 'No Sleep Data',
        message: 'Track your sleep to see patterns and improve your rest',
      );
    }

    final logs = provider.sleepLogs;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        return Dismissible(
          key: Key(log.id),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => provider.removeSleepLog(log.id),
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B4CE6).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.nightlight_round,
                  color: Color(0xFF6B4CE6),
                ),
              ),
              title: Text('${log.hours} hours'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_formatDate(log.date)),
                  if (log.notes != null && log.notes!.isNotEmpty)
                    Text(
                      log.notes!,
                      style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
              trailing: log.bedTime != null && log.wakeTime != null
                  ? Text(
                      '${DateFormat.jm().format(log.bedTime!)} - ${DateFormat.jm().format(log.wakeTime!)}',
                      style: const TextStyle(fontSize: 12),
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildStudyView(SleepStudyProvider provider, bool hasData) {
    if (!hasData) {
      return _buildEmptyState(
        icon: Icons.menu_book,
        title: 'No Study Data',
        message: 'Log your study sessions to track your progress',
      );
    }

    final logs = provider.studyLogs;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        return Dismissible(
          key: Key(log.id),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => provider.removeStudyLog(log.id),
          child: Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF50C878).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.menu_book,
                  color: Color(0xFF50C878),
                ),
              ),
              title: Text('${log.hours} hours'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_formatDate(log.date)),
                  if (log.subject != null && log.subject!.isNotEmpty)
                    Text(
                      log.subject!,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  if (log.notes != null && log.notes!.isNotEmpty)
                    Text(
                      log.notes!,
                      style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showAddLogDialog(_selectedTab),
              icon: const Icon(Icons.add),
              label: const Text('Add Entry'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final logDate = DateTime(date.year, date.month, date.day);

    if (logDate == today) {
      return 'Today';
    } else if (logDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat.yMMMd().format(date);
    }
  }

  void _showAddLogDialog(int tab) {
    if (tab == 1 || (tab == 0 && _selectedTab == 0)) {
      _showAddSleepDialog();
    } else if (tab == 2) {
      _showAddStudyDialog();
    } else {
      _showAddSleepDialog();
    }
  }

  void _showAddSleepDialog() {
    final dateController = TextEditingController();
    final hoursController = TextEditingController();
    final notesController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Sleep'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    selectedDate = date;
                    dateController.text = DateFormat.yMMMd().format(date);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: hoursController,
                decoration: const InputDecoration(
                  labelText: 'Hours of Sleep',
                  prefixIcon: Icon(Icons.nightlight_round),
                  suffixText: 'hours',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  prefixIcon: Icon(Icons.notes),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final hours = double.tryParse(hoursController.text);
              if (hours != null && hours > 0) {
                final log = SleepLog(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  date: selectedDate,
                  hours: hours,
                  notes: notesController.text.isEmpty ? null : notesController.text,
                );
                context.read<SleepStudyProvider>().addSleepLog(log);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sleep logged!')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    dateController.text = DateFormat.yMMMd().format(selectedDate);
  }

  void _showAddStudyDialog() {
    final dateController = TextEditingController();
    final hoursController = TextEditingController();
    final subjectController = TextEditingController();
    final notesController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Study Session'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    selectedDate = date;
                    dateController.text = DateFormat.yMMMd().format(date);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: hoursController,
                decoration: const InputDecoration(
                  labelText: 'Hours Studied',
                  prefixIcon: Icon(Icons.timer),
                  suffixText: 'hours',
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject (optional)',
                  prefixIcon: Icon(Icons.subject),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  prefixIcon: Icon(Icons.notes),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final hours = double.tryParse(hoursController.text);
              if (hours != null && hours > 0) {
                final log = StudyLog(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  date: selectedDate,
                  hours: hours,
                  subject: subjectController.text.isEmpty ? null : subjectController.text,
                  notes: notesController.text.isEmpty ? null : notesController.text,
                );
                context.read<SleepStudyProvider>().addStudyLog(log);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Study session logged!')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    dateController.text = DateFormat.yMMMd().format(selectedDate);
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
