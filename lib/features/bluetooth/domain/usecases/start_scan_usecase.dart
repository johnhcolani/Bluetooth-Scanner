import '../entities/bluetooth_device_entity.dart';
import '../repositories/bluetooth_repository.dart';

class StartScanUseCase {
  final BluetoothRepository repository;

  StartScanUseCase(this.repository);

  Stream<List<BluetoothDeviceEntity>> call() {
    return repository.scanDevices();
  }
}