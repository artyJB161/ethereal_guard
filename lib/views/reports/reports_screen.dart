import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Reports'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Weekly Security Incidents', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10,
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 2, color: Colors.blue)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 5, color: Colors.blue)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 3, color: Colors.blue)]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 8, color: Colors.red)]),
                    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 4, color: Colors.blue)]),
                    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 1, color: Colors.blue)]),
                    BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 2, color: Colors.blue)]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Traffic Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(2, 4),
                        const FlSpot(4, 3.5),
                        const FlSpot(6, 5),
                        const FlSpot(8, 4),
                        const FlSpot(10, 6),
                      ],
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 4,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildReportCard('Daily Summary', 'Everything looks normal today. No major threats detected.'),
            _buildReportCard('Weekly Summary', 'A total of 15 minor alerts and 1 high-risk alert were recorded.'),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}
