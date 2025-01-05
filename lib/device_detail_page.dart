import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class DeviceDetailsPage extends StatelessWidget {
  final DiscoveredDevice device;
  final VoidCallback disconnectCallback;

  const DeviceDetailsPage({Key? key, required this.device, required this.disconnectCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name.isEmpty ? "Unknown Device" : device.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Device Details",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text("Name: ${device.name.isEmpty ? "Unknown Device" : device.name}"),
            Text("ID: ${device.id}"),
            Text("RSSI: ${device.rssi}"),
            const SizedBox(height: 16),
            Text("Advertising Data:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: device.serviceData.entries.map((entry) {
                  return ListTile(
                    title: Text("Service UUID: ${entry.key}"),
                    subtitle: Text("Data: ${entry.value}"),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            SafeArea(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    disconnectCallback(); // Disconnect the device
                    Navigator.pop(context); // Go back to the previous page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  child: const Text("Disconnect"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
