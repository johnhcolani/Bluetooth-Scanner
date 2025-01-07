import '../repositories/bluetooth_repository.dart';

class DisconnectDeviceUseCase {
  final BluetoothRepository repository;

  DisconnectDeviceUseCase(this.repository);

  Future<void> call() async {
    await repository.disconnectDevice();
  }
}