import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/bluetooth_device_entity.dart';
import '../bloc/bluetooth_bloc.dart';
import '../bloc/bluetooth_event.dart';
import '../bloc/bluetooth_state.dart';

class DeviceDetailsPage extends StatelessWidget {
  final BluetoothDeviceEntity device;

  const DeviceDetailsPage({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name.isEmpty ? "Unknown Device" : device.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<BluetoothBloc, BluetoothState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Device Details",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text("Name: ${device.name}"),
                Text("ID: ${device.id}"),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<BluetoothBloc>().add(DisconnectDeviceEvent());
                      Navigator.pop(context); // Return to scanner screen
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("Disconnect"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}