import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/network_viewmodel.dart';
import '../../models/device.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NetworkViewModel>();
    final filteredDevices = viewModel.devices.where((d) => 
      d.name.toLowerCase().contains(_searchQuery.toLowerCase()) || 
      d.ipAddress.contains(_searchQuery)
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Connected Devices'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search devices...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredDevices.isEmpty
                    ? const Center(child: Text('No devices found'))
                    : ListView.builder(
                        itemCount: filteredDevices.length,
                        itemBuilder: (context, index) {
                          final device = filteredDevices[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: device.status == DeviceStatus.online ? Colors.green.shade100 : Colors.grey.shade200,
                              child: Icon(
                                device.name.contains('Phone') ? Icons.phone_android : Icons.laptop,
                                color: device.status == DeviceStatus.online ? Colors.green : Colors.grey,
                              ),
                            ),
                            title: Text(device.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(device.ipAddress),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  device.status == DeviceStatus.online ? 'Online' : 'Offline',
                                  style: TextStyle(
                                    color: device.status == DeviceStatus.online ? Colors.green : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${device.lastActive.hour}:${device.lastActive.minute}',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
