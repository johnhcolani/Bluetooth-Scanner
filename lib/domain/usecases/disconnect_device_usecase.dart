import '../repositories/bluetooth_repository.dart';

class DisconnectDeviceUseCase {
  final BluetoothRepository repository;

  DisconnectDeviceUseCase(this.repository);

  Future<void> execute() {
    return repository.disconnectDevice();
  }
}