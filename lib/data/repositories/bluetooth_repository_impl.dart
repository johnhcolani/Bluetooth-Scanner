import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import '../../domain/entities/device_entity.dart';
import '../../domain/repositories/bluetooth_repository.dart';
import '../models/discovered_device_model.dart';

class BluetoothRepositoryImpl implements BluetoothRepository {
  final FlutterReactiveBle _ble;

  StreamSubscription? _connectionSubscription;

  BluetoothRepositoryImpl(this._ble);

  @override
  Stream<List<DeviceEntity>> scanForDevices() {
    return _ble.scanForDevices(withServices: []).map((device) {
      return [
        DiscoveredDeviceModel.fromReactiveBle(device).toEntity(),
      ];
    });
  }

  @override
  Future<void> connectToDevice(String deviceId) async {
    await _connectionSubscription?.cancel();
    _connectionSubscription = _ble.connectToDevice(id: deviceId).listen(
          (connectionState) {
        if (connectionState.connectionState == DeviceConnectionState.connected) {
          print("Connected to device: $deviceId");
        } else if (connectionState.connectionState == DeviceConnectionState.disconnected) {
          print("Disconnected from device: $deviceId");
        }
      },
      onError: (error) {
        print("Connection error: $error");
      },
    );
  }

  @override
  Future<void> disconnectDevice() async {
    await _connectionSubscription?.cancel();
    _connectionSubscription = null;
  }
}
