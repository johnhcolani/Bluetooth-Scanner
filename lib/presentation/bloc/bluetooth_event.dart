import '../../domain/entities/device_entity.dart';

abstract class BluetoothEvent {}

// Event to start scanning for devices
class StartScanEvent extends BluetoothEvent {}

// Event to stop scanning
class StopScanEvent extends BluetoothEvent {}

// Event to connect to a device
class ConnectToDeviceEvent extends BluetoothEvent {
  final DeviceEntity device;

  ConnectToDeviceEvent(this.device);
}

// Event to disconnect from a device
class DisconnectDeviceEvent extends BluetoothEvent {}
