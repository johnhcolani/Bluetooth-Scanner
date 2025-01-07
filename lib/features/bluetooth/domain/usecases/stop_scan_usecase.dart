import '../repositories/bluetooth_repository.dart';

class StopScanUseCase {
  final BluetoothRepository repository;

  StopScanUseCase(this.repository);

  Future<void> call() async {
    await repository.stopScan();
  }
}