import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'device_detail_page.dart';

class BluetoothScannerScreen extends StatefulWidget {
  const BluetoothScannerScreen({Key? key}) : super(key: key);

  @override
  _BluetoothScannerScreenState createState() => _BluetoothScannerScreenState();
}

class _BluetoothScannerScreenState extends State<BluetoothScannerScreen> {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  final List<DiscoveredDevice> _devices = [];
  StreamSubscription? _scanSubscription;
  bool _isScanning = false;
  String _connectedDeviceId = '';
  DiscoveredDevice? _connectedDevice;

  @override
  void dispose() {
    _scanSubscription?.cancel();
    super.dispose();
  }

  void _startScan() {
    setState(() {
      _isScanning = true;
      _devices.clear(); // Clear the list for new devices, but keep connected device
      if (_connectedDevice != null) {
        _devices.add(_connectedDevice!); // Preserve connected device
      }
    });
    _scanSubscription = _ble.scanForDevices(withServices: []).listen((device) {
      if (!_devices.any((d) => d.id == device.id)) {
        setState(() {
          _devices.add(device);
        });
      }
    }, onError: (error) {
      print("Scan error: $error");
      setState(() {
        _isScanning = false;
      });
    });
  }

  void _stopScan() {
    _scanSubscription?.cancel();
    setState(() {
      _isScanning = false;
    });
  }

  Future<void> _refreshDevices() async {
    _stopScan();

    await Future.delayed(const Duration(milliseconds: 500));

    _startScan();

    await Future.delayed(const Duration(seconds: 2));
  }

  void _connectToDevice(BuildContext context, DiscoveredDevice device) {
    _ble.connectToDevice(id: device.id).listen((connectionState) {
      setState(() {
        if (connectionState.connectionState == DeviceConnectionState.connected) {
          _connectedDeviceId = device.id;
          _connectedDevice = device; // Save the connected device
        } else if (connectionState.connectionState == DeviceConnectionState.disconnected) {
          _connectedDeviceId = '';
          _connectedDevice = null; // Clear the connected device
        }
      });
    }, onError: (error) {
      print("Connection error: $error");
    });
  }

  void _disconnectFromDevice() {
    if (_connectedDeviceId.isNotEmpty) {
      _ble.deinitialize();
      setState(() {
        _connectedDeviceId = '';
        _connectedDevice = null; // Clear the connected device
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bluetooth Devices")),
      body: Column(
        children: [
          // Row for Bluetooth Icon, Scanning Button, and Navigate Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bluetooth Icon
                Icon(
                  Icons.bluetooth,
                  size: 40,
                  color: _connectedDevice != null ? Colors.blue : Colors.grey,
                ),
                // Start/Stop Scanning Button
                ElevatedButton(
                  onPressed: _isScanning ? _stopScan : _startScan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isScanning ? Colors.red : Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  child: Text(
                    _isScanning ? "Stop Scanning" : "Start Scanning",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                // Navigate to Details Button (Visible if connected)
                if (_connectedDevice != null)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DeviceDetailsPage(device: _connectedDevice!, disconnectCallback: _disconnectFromDevice),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    child: const Text(
                      "Go to Details",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
              ],
            ),
          ),
          // Device List with Pull-to-Refresh
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshDevices,
              child: _devices.isEmpty
                  ? const Center(child: Text("No devices found."))
                  : ListView.builder(
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  final device = _devices[index];
                  final isConnected = _connectedDeviceId == device.id;

                  return Card(
                    child: ListTile(
                      title: Text(device.name.isEmpty ? "Unknown Device" : device.name),
                      subtitle: Text(device.id),
                      trailing: ElevatedButton(
                        onPressed: () {
                          if (isConnected) {
                            _disconnectFromDevice();
                          } else {
                            _connectToDevice(context, device);
                          }
                        },
                        child: Text(isConnected ? "Disconnect" : "Connect"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
