import '../entities/bluetooth_device_entity.dart';

abstract class BluetoothRepository {
  /// Starts scanning for Bluetooth devices and returns a stream of discovered devices.
  Stream<List<BluetoothDeviceEntity>> scanDevices();

  /// Connects to a specific Bluetooth device using its [deviceId].
  Future<void> connectToDevice(String deviceId);

  /// Disconnects from the currently connected Bluetooth device.
  Future<void> disconnectDevice();

  Future<void> stopScan(); // New method
}