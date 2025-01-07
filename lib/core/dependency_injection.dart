import 'package:get_it/get_it.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import '../features/bluetooth/data/repositories/bluetooth_repository_impl.dart';
import '../features/bluetooth/domain/repositories/bluetooth_repository.dart';
import '../features/bluetooth/domain/usecases/start_scan_usecase.dart';
import '../features/bluetooth/domain/usecases/stop_scan_usecase.dart';
import '../features/bluetooth/domain/usecases/connect_to_device_usecase.dart';
import '../features/bluetooth/domain/usecases/disconnect_device_usecase.dart';
import '../features/bluetooth/presentation/bloc/bluetooth_bloc.dart';

final sl = GetIt.instance;

void init() {
  // External Dependencies
  sl.registerLazySingleton(() => FlutterReactiveBle());

  // Data Layer: Repository Implementation
  sl.registerLazySingleton<BluetoothRepository>(
        () => BluetoothRepositoryImpl(sl()), // Inject FlutterReactiveBle into repository
  );

  // Domain Layer: Use Cases
  sl.registerLazySingleton(() => StartScanUseCase(sl()));
  sl.registerLazySingleton(() => StopScanUseCase(sl()));
  sl.registerLazySingleton(() => ConnectToDeviceUseCase(sl()));
  sl.registerLazySingleton(() => DisconnectDeviceUseCase(sl()));

  // Presentation Layer: Bloc
  sl.registerFactory(() => BluetoothBloc(
    startScan: sl(),
    stopScan: sl(),
    connectToDevice: sl(),
    disconnectDevice: sl(),
  ));
}