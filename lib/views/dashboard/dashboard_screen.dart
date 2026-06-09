import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/network_viewmodel.dart';
import '../../widgets/summary_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NetworkViewModel>().refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NetworkViewModel>();
    final stats = viewModel.stats;

    return Scaffold(
      appBar: AppBar(
        title: const Text('NetGuard Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => viewModel.refreshData(),
          ),
        ],
      ),
      body: viewModel.isLoading && stats == null
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => viewModel.refreshData(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatusHeader(stats),
                    const SizedBox(height: 24),
                    const Text('Network Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.5,
                      children: [
                        SummaryCard(
                          title: 'Devices',
                          value: '${stats?.connectedDevicesCount ?? 0}',
                          icon: Icons.devices,
                          color: Colors.blue,
                        ),
                        SummaryCard(
                          title: 'Alerts',
                          value: '${stats?.activeAlertsCount ?? 0}',
                          icon: Icons.warning_amber_rounded,
                          color: Colors.orange,
                        ),
                        SummaryCard(
                          title: 'Latency',
                          value: '${stats?.latency ?? 0} ms',
                          icon: Icons.speed,
                          color: Colors.green,
                        ),
                        SummaryCard(
                          title: 'Health',
                          value: '${stats?.healthScore ?? 0}%',
                          icon: Icons.health_and_safety,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text('Real-time Usage', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildUsageCard(stats),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildStatusHeader(dynamic stats) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.wifi, size: 48, color: Colors.white),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Network Status',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                Text(
                  stats != null ? 'SECURE & ONLINE' : 'CHECKING...',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.verified_user, color: Colors.greenAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildUsageCard(dynamic stats) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSpeedItem('Download', '${stats?.downloadSpeed ?? 0} Mbps', Icons.arrow_downward, Colors.green),
                _buildSpeedItem('Upload', '${stats?.uploadSpeed ?? 0} Mbps', Icons.arrow_upward, Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
