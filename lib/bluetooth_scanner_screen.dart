import 'package:bluetooth_detector/presentation/bloc/bluetooth_bloc.dart';
import 'package:bluetooth_detector/presentation/bloc/bluetooth_event.dart';
import 'package:bluetooth_detector/presentation/bloc/bluetooyh_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'device_detail_page.dart';

class BluetoothScannerScreen extends StatelessWidget {
  const BluetoothScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bluetooth Devices"),
        actions: [
          BlocBuilder<BluetoothBloc, BluetoothState>(
            builder: (context, state) {
              return Icon(
                Icons.bluetooth,
                size: 40,
                color: state.connectedDevice != null ? Colors.blue : Colors.grey,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Scanning and Connected Device Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<BluetoothBloc, BluetoothState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.isScanning
                          ? () => context.read<BluetoothBloc>().add(StopScanEvent())
                          : () => context.read<BluetoothBloc>().add(StartScanEvent()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isScanning
                            ? Colors.red.shade400
                            : Colors.green.shade400,
                      ),
                      child: Text(
                        state.isScanning ? "Stop Scanning" : "Start Scanning",
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
                BlocBuilder<BluetoothBloc, BluetoothState>(
                  builder: (context, state) {
                    if (state.connectedDevice != null) {
                      return ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeviceDetailsPage(
                                device: state.connectedDevice!,
                                disconnectCallback: () {
                                  context.read<BluetoothBloc>().add(DisconnectDeviceEvent());
                                },
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.bluetooth_connected, color: Colors.white),
                        label: const Text(
                          "Go to Connected",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
          // Device List
          Expanded(
            child: BlocBuilder<BluetoothBloc, BluetoothState>(
              builder: (context, state) {
                if (state.devices.isEmpty) {
                  return const Center(child: Text("No devices found."));
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<BluetoothBloc>().add(StopScanEvent());
                    await Future.delayed(const Duration(milliseconds: 500));
                    context.read<BluetoothBloc>().add(StartScanEvent());
                  },
                  child: ListView.builder(
                    itemCount: state.devices.length,
                    itemBuilder: (context, index) {
                      final device = state.devices[index];
                      final isConnected = state.connectedDevice?.id == device.id;

                      return Card(
                        child: ListTile(
                          title: Text(device.name.isEmpty ? "Unknown Device" : device.name),
                          subtitle: Text(device.id),
                          trailing: ElevatedButton.icon(
                            onPressed: isConnected
                                ? null
                                : () => context
                                .read<BluetoothBloc>()
                                .add(ConnectToDeviceEvent(device)),
                            icon: Icon(
                              Icons.bluetooth,
                              color: isConnected ? Colors.blue : Colors.grey[600],
                            ),
                            label: Text(isConnected ? "Connected" : "Connect"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isConnected
                                  ? Colors.blue.shade900
                                  : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      );
                    },
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
