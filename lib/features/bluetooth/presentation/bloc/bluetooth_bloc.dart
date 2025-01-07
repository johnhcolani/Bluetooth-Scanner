import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/bluetooth_device_entity.dart';
import '../../domain/usecases/start_scan_usecase.dart';
import '../../domain/usecases/stop_scan_usecase.dart';
import '../../domain/usecases/connect_to_device_usecase.dart';
import '../../domain/usecases/disconnect_device_usecase.dart';
import 'bluetooth_event.dart';
import 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  final StartScanUseCase startScan;
  final StopScanUseCase stopScan;
  final ConnectToDeviceUseCase connectToDevice;
  final DisconnectDeviceUseCase disconnectDevice;

  BluetoothBloc({
    required this.startScan,
    required this.stopScan,
    required this.connectToDevice,
    required this.disconnectDevice,
  }) : super(BluetoothInitial()) {
    on<StartScanEvent>(_onStartScan);
    on<StopScanEvent>(_onStopScan);
    on<ConnectToDeviceEvent>(_onConnectToDevice);
    on<DisconnectDeviceEvent>(_onDisconnectDevice);
  }

  Future<void> _onStartScan(StartScanEvent event, Emitter<BluetoothState> emit) async {
    emit(BluetoothLoading());
    try {
      await emit.forEach(
        startScan(),
        onData: (devices) => BluetoothScanSuccess(devices),
        onError: (_, __) => BluetoothError("Failed to scan devices"),
      );
    } catch (e) {
      emit(BluetoothError(e.toString()));
    }
  }

  Future<void> _onStopScan(StopScanEvent event, Emitter<BluetoothState> emit) async {
    try {
      await stopScan();
      emit(BluetoothInitial()); // Return to the initial state after stopping the scan
    } catch (e) {
      emit(BluetoothError("Failed to stop scanning: $e"));
    }
  }

  Future<void> _onConnectToDevice(ConnectToDeviceEvent event, Emitter<BluetoothState> emit) async {
    emit(BluetoothLoading());
    try {
      await connectToDevice(event.deviceId);
      emit(BluetoothConnected(BluetoothDeviceEntity(
        id: event.deviceId,
        name: "Connected Device", // Optionally replace with actual data if available
        rssi: -1, // Placeholder for RSSI
      )));
    } catch (e) {
      emit(BluetoothError("Failed to connect to device: $e"));
    }
  }

  Future<void> _onDisconnectDevice(DisconnectDeviceEvent event, Emitter<BluetoothState> emit) async {
    emit(BluetoothLoading());
    try {
      await disconnectDevice();
      emit(BluetoothDisconnected());
    } catch (e) {
      emit(BluetoothError("Failed to disconnect device: $e"));
    }
  }
}