import '../models/device.dart';
import '../models/alert.dart';
import '../models/network_stats.dart';
import '../services/mock_api_service.dart';

class NetworkRepository {
  final MockApiService _apiService;

  NetworkRepository(this._apiService);

  Future<List<Device>> fetchDevices() => _apiService.getDevices();
  Future<List<SecurityAlert>> fetchAlerts() => _apiService.getAlerts();
  Future<NetworkStats> fetchNetworkStats() => _apiService.getNetworkStats();
}
