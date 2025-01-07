import 'package:bluetooth_detector/core/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bluetooth_bloc.dart';
import '../bloc/bluetooth_event.dart';
import '../bloc/bluetooth_state.dart';
import 'device_detail_page.dart';


class BluetoothScannerScreen extends StatelessWidget {
  const BluetoothScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<BluetoothBloc>(), // Inject BluetoothBloc
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Bluetooth Devices"),
          actions: [
            BlocBuilder<BluetoothBloc, BluetoothState>(
              builder: (context, state) {
                final isConnected = state is BluetoothConnected;
                return Icon(
                  Icons.bluetooth,
                  size: 40,
                  color: isConnected ? Colors.blue : Colors.grey,
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<BluetoothBloc, BluetoothState>(
                    builder: (context, state) {
                      final isScanning = state is BluetoothLoading;
                      return ElevatedButton(
                        onPressed: isScanning
                            ? () => context.read<BluetoothBloc>().add(StopScanEvent())
                            : () => context.read<BluetoothBloc>().add(StartScanEvent()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isScanning ? Colors.red : Colors.green,
                        ),
                        child: Text(isScanning ? "Stop Scanning" : "Start Scanning"),
                      );
                    },
                  ),
                  BlocBuilder<BluetoothBloc, BluetoothState>(
                    builder: (context, state) {
                      if (state is BluetoothConnected) {
                        return ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DeviceDetailsPage(device: state.device),
                              ),
                            );
                          },
                          icon: const Icon(Icons.bluetooth_connected),
                          label: const Text("Go to Connected"),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<BluetoothBloc, BluetoothState>(
                builder: (context, state) {
                  if (state is BluetoothLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BluetoothScanSuccess) {
                    if (state.devices.isEmpty) {
                      return const Center(child: Text("No devices found."));
                    }
                    return ListView.builder(
                      itemCount: state.devices.length,
                      itemBuilder: (context, index) {
                        final device = state.devices[index];
                        return ListTile(
                          title: Text(device.name),
                          subtitle: Text(device.id),
                          trailing: ElevatedButton(
                            onPressed: () => context.read<BluetoothBloc>().add(
                              ConnectToDeviceEvent(device.id),
                            ),
                            child: const Text("Connect"),
                          ),
                        );
                      },
                    );
                  } else if (state is BluetoothError) {
                    return Center(child: Text("Error: ${state.message}"));
                  }
                  return const Center(child: Text("Press 'Start Scanning' to discover devices."));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}