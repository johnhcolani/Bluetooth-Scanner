import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import '../../domain/entities/bluetooth_device_entity.dart';
import '../../domain/repositories/bluetooth_repository.dart';
import '../models/bluetooth_device_model.dart';

class BluetoothRepositoryImpl implements BluetoothRepository {
  final FlutterReactiveBle _ble;
  StreamSubscription? _scanSubscription; // To manage scan cancellation

  BluetoothRepositoryImpl(this._ble);

  @override
  Stream<List<BluetoothDeviceEntity>> scanDevices() {
    final deviceList = <BluetoothDeviceEntity>[];
    final controller = StreamController<List<BluetoothDeviceEntity>>();

    _scanSubscription = _ble.scanForDevices(withServices: []).listen((device) {
      final model = BluetoothDeviceModel.fromRawData(
        id: device.id,
        name: device.name,
        rssi: device.rssi,
      );
      deviceList.add(model.toEntity());
      controller.add(List.unmodifiable(deviceList));
    }, onError: (error) {
      controller.addError(error);
    });

    return controller.stream;
  }

  @override
  Future<void> stopScan() async {
    await _scanSubscription?.cancel();
    _scanSubscription = null;
  }

  @override
  Future<void> connectToDevice(String deviceId) async {
    await _ble.connectToDevice(id: deviceId).first;
  }

  @override
  Future<void> disconnectDevice() async {
    await _ble.deinitialize();
  }
}