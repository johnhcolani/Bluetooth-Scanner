import '../../domain/entities/bluetooth_device_entity.dart';

abstract class BluetoothState {}

class BluetoothInitial extends BluetoothState {}

class BluetoothLoading extends BluetoothState {}

class BluetoothScanSuccess extends BluetoothState {
  final List<BluetoothDeviceEntity> devices;

  BluetoothScanSuccess(this.devices);
}

class BluetoothConnected extends BluetoothState {
  final BluetoothDeviceEntity device;

  BluetoothConnected(this.device);
}

class BluetoothDisconnected extends BluetoothState {}

class BluetoothError extends BluetoothState {
  final String message;

  BluetoothError(this.message);
}