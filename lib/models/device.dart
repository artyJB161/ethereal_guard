enum DeviceStatus { online, offline }

class Device {
  final String id;
  final String name;
  final String ipAddress;
  final DeviceStatus status;
  final DateTime lastActive;
  final String macAddress;

  Device({
    required this.id,
    required this.name,
    required this.ipAddress,
    required this.status,
    required this.lastActive,
    required this.macAddress,
  });
}
