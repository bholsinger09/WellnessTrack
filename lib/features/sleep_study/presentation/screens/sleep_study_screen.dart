import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SleepStudyScreen extends StatefulWidget {
  const SleepStudyScreen({Key? key}) : super(key: key);

  @override
  State<SleepStudyScreen> createState() => _SleepStudyScreenState();
}

class _SleepStudyScreenState extends State<SleepStudyScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
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
                    label: 'Chart',
                    isSelected: _selectedTab == 0,
                    onTap: () => setState(() => _selectedTab = 0),
                  ),
                ),
                Expanded(
                  child: _TabButton(
                    label: 'Log Data',
                    isSelected: _selectedTab == 1,
                    onTap: () => setState(() => _selectedTab = 1),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _selectedTab == 0 ? _buildChartView() : _buildLogView(),
          ),
        ],
      ),
      floatingActionButton: _selectedTab == 1
          ? FloatingActionButton(
              onPressed: _showAddLogDialog,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildChartView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Balance',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text('${value.toInt()}h');
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        if (value.toInt() < days.length) {
                          return Text(days[value.toInt()]);
                        }
                        return const Text('');
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
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 7),
                      const FlSpot(1, 6.5),
                      const FlSpot(2, 8),
                      const FlSpot(3, 7.5),
                      const FlSpot(4, 6),
                      const FlSpot(5, 8.5),
                      const FlSpot(6, 9),
                    ],
                    isCurved: true,
                    color: const Color(0xFF6B4CE6),
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                  ),
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 5),
                      const FlSpot(1, 6),
                      const FlSpot(2, 4),
                      const FlSpot(3, 7),
                      const FlSpot(4, 8),
                      const FlSpot(5, 3),
                      const FlSpot(6, 2),
                    ],
                    isCurved: true,
                    color: const Color(0xFF50C878),
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                  ),
                ],
              ),
            ),
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

  Widget _buildLogView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Icon(
              index % 2 == 0 ? Icons.nightlight_round : Icons.menu_book,
              color: index % 2 == 0
                  ? const Color(0xFF6B4CE6)
                  : const Color(0xFF50C878),
            ),
            title: Text(
              index % 2 == 0 ? 'Sleep Log' : 'Study Log',
            ),
            subtitle: Text('${7 + index % 3} hours'),
            trailing: Text(
              '${DateTime.now().subtract(Duration(days: index)).day}/${DateTime.now().month}',
            ),
          ),
        );
      },
    );
  }

  void _showAddLogDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Log'),
        content: const Text('Log entry form will be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Log saved!')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
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
