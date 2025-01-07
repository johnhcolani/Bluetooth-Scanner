import '../../domain/entities/bluetooth_device_entity.dart';

abstract class BluetoothEvent {}

class StartScanEvent extends BluetoothEvent {}

class StopScanEvent extends BluetoothEvent {}

class ConnectToDeviceEvent extends BluetoothEvent {
  final String deviceId;

  ConnectToDeviceEvent(this.deviceId);
}

class DisconnectDeviceEvent extends BluetoothEvent {}