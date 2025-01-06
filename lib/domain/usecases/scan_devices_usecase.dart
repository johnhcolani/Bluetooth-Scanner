import '../entities/device_entity.dart';
import '../entities/discovered_device.dart';
import '../repositories/bluetooth_repository.dart';

class ScanDevicesUseCase {
  final BluetoothRepository repository;

  ScanDevicesUseCase(this.repository);

  Stream<List<DeviceEntity>> execute() {
    return repository.scanForDevices();
  }
}