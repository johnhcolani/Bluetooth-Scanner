import 'package:flutter/material.dart';
import '../../domain/entities/device_entity.dart';

class DeviceDetailsPage extends StatelessWidget {
  final DeviceEntity device;
  final VoidCallback disconnectCallback;

  const DeviceDetailsPage({
    Key? key,
    required this.device,
    required this.disconnectCallback,
  }) : super(key: key);

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
            const Spacer(),
            SafeArea(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    disconnectCallback();
                    Navigator.pop(context);
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
