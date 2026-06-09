import 'package:flutter/material.dart';
import '../repositories/network_repository.dart';
import '../models/device.dart';
import '../models/alert.dart';
import '../models/network_stats.dart';

/// ViewModel responsible for managing network-related state and data fetching.
/// It interacts with the [NetworkRepository] to fetch devices, alerts, and stats.
class NetworkViewModel extends ChangeNotifier {
  final NetworkRepository _networkRepository;

  List<Device> _devices = [];
  List<SecurityAlert> _alerts = [];
  NetworkStats? _stats;
  bool _isLoading = false;

  NetworkViewModel(this._networkRepository);

  List<Device> get devices => _devices;
  List<SecurityAlert> get alerts => _alerts;
  NetworkStats? get stats => _stats;
  bool get isLoading => _isLoading;

  /// Fetches the latest network data from the repository.
  /// Uses [Future.wait] to fetch multiple data points concurrently.
  Future<void> refreshData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final results = await Future.wait([
        _networkRepository.fetchDevices(),
        _networkRepository.fetchAlerts(),
        _networkRepository.fetchNetworkStats(),
      ]);

      _devices = results[0] as List<Device>;
      _alerts = results[1] as List<SecurityAlert>;
      _stats = results[2] as NetworkStats;
    } catch (e) {
      // Handle error
    }

    _isLoading = false;
    notifyListeners();
  }
}
