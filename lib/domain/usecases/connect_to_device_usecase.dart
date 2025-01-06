import '../repositories/bluetooth_repository.dart';

class ConnectToDeviceUseCase {
  final BluetoothRepository repository;

  ConnectToDeviceUseCase(this.repository);

  Future<void> execute(String deviceId) {
    return repository.connectToDevice(deviceId);
  }
}
