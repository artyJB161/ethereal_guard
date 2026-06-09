enum AlertSeverity { high, medium, low }

class SecurityAlert {
  final String id;
  final String title;
  final String description;
  final AlertSeverity severity;
  final DateTime timestamp;
  final bool isRead;

  SecurityAlert({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.timestamp,
    this.isRead = false,
  });
}
