import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/scan_devices_usecase.dart';
import '../../domain/usecases/connect_to_device_usecase.dart';
import '../../domain/usecases/disconnect_device_usecase.dart';
import 'bluetooth_event.dart';
import 'bluetooyh_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothState> {
  final ScanDevicesUseCase _scanDevicesUseCase;
  final ConnectToDeviceUseCase _connectToDeviceUseCase;
  final DisconnectDeviceUseCase _disconnectDeviceUseCase;

  BluetoothBloc(
      this._scanDevicesUseCase,
      this._connectToDeviceUseCase,
      this._disconnectDeviceUseCase,
      ) : super(const BluetoothInitialState()) {
    on<StartScanEvent>(_onStartScan);
    on<StopScanEvent>(_onStopScan);
    on<ConnectToDeviceEvent>(_onConnectToDevice);
    on<DisconnectDeviceEvent>(_onDisconnectDevice);
  }

  void _onStartScan(StartScanEvent event, Emitter<BluetoothState> emit) {
    emit(BluetoothScanningState(
      devices: state.devices,
      connectedDevice: state.connectedDevice,
    ));

    _scanDevicesUseCase.execute().listen((devices) {
      emit(BluetoothScanningState(
        devices: devices,
        connectedDevice: state.connectedDevice,
      ));
    });
  }

  void _onStopScan(StopScanEvent event, Emitter<BluetoothState> emit) {
    emit(BluetoothStoppedState(
      devices: state.devices,
      connectedDevice: state.connectedDevice,
    ));
  }

  Future<void> _onConnectToDevice(
      ConnectToDeviceEvent event, Emitter<BluetoothState> emit) async {
    await _connectToDeviceUseCase.execute(event.device.id);
    emit(BluetoothConnectedState(
      devices: state.devices,
      connectedDevice: event.device,
    ));
  }

  Future<void> _onDisconnectDevice(
      DisconnectDeviceEvent event, Emitter<BluetoothState> emit) async {
    await _disconnectDeviceUseCase.execute();
    emit(BluetoothDisconnectedState(
      devices: state.devices,
    ));
  }
}

