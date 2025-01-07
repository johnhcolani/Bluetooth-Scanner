import 'package:get_it/get_it.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import '../features/bluetooth/data/repositories/bluetooth_repository_impl.dart';
import '../features/bluetooth/domain/repositories/bluetooth_repository.dart';
import '../features/bluetooth/domain/usecases/connect_to_device_usecase.dart';
import '../features/bluetooth/domain/usecases/disconnect_device_usecase.dart';
import '../features/bluetooth/domain/usecases/start_scan_usecase.dart';
import '../features/bluetooth/domain/usecases/stop_scan_usecase.dart';
import '../features/bluetooth/presentation/bloc/bluetooth_bloc.dart';


GetIt locator = GetIt.instance;

setup() async {
  // External Dependencies
  locator.registerSingleton<FlutterReactiveBle>(FlutterReactiveBle());

  // Repository
  locator.registerSingleton<BluetoothRepository>(
    BluetoothRepositoryImpl(locator()),
  );

  // Use Cases
  locator.registerSingleton<StartScanUseCase>(StartScanUseCase(locator()));
  locator.registerSingleton<StopScanUseCase>(StopScanUseCase(locator()));
  locator.registerSingleton<ConnectToDeviceUseCase>(ConnectToDeviceUseCase(locator()));
  locator.registerSingleton<DisconnectDeviceUseCase>(DisconnectDeviceUseCase(locator()));

  // Bloc
  locator.registerSingleton<BluetoothBloc>(
    BluetoothBloc(
      startScan: locator(),
      stopScan: locator(),
      connectToDevice: locator(),
      disconnectDevice: locator(),
    ),
  );
}
