import '../repositories/bluetooth_repository.dart';

class ConnectToDeviceUseCase {
  final BluetoothRepository repository;

  ConnectToDeviceUseCase(this.repository);

  Future<void> call(String deviceId) async {
    await repository.connectToDevice(deviceId);
  }
}