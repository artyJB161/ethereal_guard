import 'dart:async';
import '../models/device.dart';
import '../models/alert.dart';
import '../models/network_stats.dart';

class MockApiService {
  // Simulate network delay
  Future<void> _delay() => Future.delayed(const Duration(milliseconds: 800));

  Future<List<Device>> getDevices() async {
    await _delay();
    return [
      Device(
        id: '1',
        name: 'Work Laptop',
        ipAddress: '192.168.1.15',
        status: DeviceStatus.online,
        lastActive: DateTime.now(),
        macAddress: '00:0a:95:9d:68:16',
      ),
      Device(
        id: '2',
        name: 'iPhone 13',
        ipAddress: '192.168.1.22',
        status: DeviceStatus.online,
        lastActive: DateTime.now(),
        macAddress: 'BC:EE:7B:00:11:22',
      ),
      Device(
        id: '3',
        name: 'Smart TV',
        ipAddress: '192.168.1.50',
        status: DeviceStatus.offline,
        lastActive: DateTime.now().subtract(const Duration(hours: 5)),
        macAddress: 'AA:BB:CC:DD:EE:FF',
      ),
      Device(
        id: '4',
        name: 'Home PC',
        ipAddress: '192.168.1.10',
        status: DeviceStatus.online,
        lastActive: DateTime.now(),
        macAddress: '11:22:33:44:55:66',
      ),
    ];
  }

  Future<List<SecurityAlert>> getAlerts() async {
    await _delay();
    return [
      SecurityAlert(
        id: '1',
        title: 'Port Scanning Detected',
        description: 'Suspicious activity from IP 192.168.1.105 attempting to scan multiple ports.',
        severity: AlertSeverity.high,
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
      SecurityAlert(
        id: '2',
        title: 'New Device Connected',
        description: 'A previously unknown device (Samsung Fridge) connected to the network.',
        severity: AlertSeverity.low,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      SecurityAlert(
        id: '3',
        title: 'Unusual Traffic Pattern',
        description: 'High volume of outbound traffic detected from Work Laptop to an unknown server.',
        severity: AlertSeverity.medium,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  Future<NetworkStats> getNetworkStats() async {
    await _delay();
    return NetworkStats(
      latency: 24.5,
      downloadSpeed: 85.2,
      uploadSpeed: 12.4,
      connectedDevicesCount: 8,
      activeAlertsCount: 3,
      healthScore: 88,
    );
  }
}
