import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../viewmodels/network_viewmodel.dart';
import '../../models/alert.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NetworkViewModel>();
    final alerts = viewModel.alerts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Alerts'),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : alerts.isEmpty
              ? const Center(child: Text('No alerts detected'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: alerts.length,
                  itemBuilder: (context, index) {
                    final alert = alerts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: ExpansionTile(
                        leading: _getSeverityIcon(alert.severity),
                        title: Text(alert.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(DateFormat('MMM dd, HH:mm').format(alert.timestamp)),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(alert.description),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Investigate'),
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('Dismiss'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  Widget _getSeverityIcon(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.high:
        return const Icon(Icons.error, color: Colors.red);
      case AlertSeverity.medium:
        return const Icon(Icons.warning, color: Colors.orange);
      case AlertSeverity.low:
        return const Icon(Icons.info, color: Colors.blue);
    }
  }
}
