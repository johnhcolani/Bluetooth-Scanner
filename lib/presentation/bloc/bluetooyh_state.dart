import '../../domain/entities/device_entity.dart';

abstract class BluetoothState {
  final List<DeviceEntity> devices;
  final DeviceEntity? connectedDevice;
  final bool isScanning;

  const BluetoothState({
    required this.devices,
    required this.connectedDevice,
    required this.isScanning,
  });
}

class BluetoothInitialState extends BluetoothState {
  const BluetoothInitialState()
      : super(devices: const [], connectedDevice: null, isScanning: false);
}

class BluetoothScanningState extends BluetoothState {
  const BluetoothScanningState({
    required List<DeviceEntity> devices,
    required DeviceEntity? connectedDevice,
  }) : super(devices: devices, connectedDevice: connectedDevice, isScanning: true);
}

class BluetoothStoppedState extends BluetoothState {
  const BluetoothStoppedState({
    required List<DeviceEntity> devices,
    required DeviceEntity? connectedDevice,
  }) : super(devices: devices, connectedDevice: connectedDevice, isScanning: false);
}

class BluetoothConnectedState extends BluetoothState {
  const BluetoothConnectedState({
    required List<DeviceEntity> devices,
    required DeviceEntity connectedDevice,
  }) : super(devices: devices, connectedDevice: connectedDevice, isScanning: false);
}

class BluetoothDisconnectedState extends BluetoothState {
  const BluetoothDisconnectedState({
    required List<DeviceEntity> devices,
  }) : super(devices: devices, connectedDevice: null, isScanning: false);
}
