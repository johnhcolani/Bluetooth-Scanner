import '../entities/device_entity.dart';
import '../entities/discovered_device.dart';

abstract class BluetoothRepository {
  Stream<List<DeviceEntity>> scanForDevices();
  Future<void> connectToDevice(String deviceId);
  Future<void> disconnectDevice();
}