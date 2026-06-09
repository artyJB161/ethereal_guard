class NetworkStats {
  final double latency; // ms
  final double downloadSpeed; // Mbps
  final double uploadSpeed; // Mbps
  final int connectedDevicesCount;
  final int activeAlertsCount;
  final int healthScore; // 0-100

  NetworkStats({
    required this.latency,
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.connectedDevicesCount,
    required this.activeAlertsCount,
    required this.healthScore,
  });
}
