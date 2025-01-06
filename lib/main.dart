import 'package:bluetooth_detector/presentation/bloc/bluetooth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'bluetooth_scanner_screen.dart';
import 'data/repositories/bluetooth_repository_impl.dart';
import 'domain/usecases/connect_to_device_usecase.dart';
import 'domain/usecases/disconnect_device_usecase.dart';
import 'domain/usecases/scan_devices_usecase.dart';


void main() {
  final ble = FlutterReactiveBle();
  final repository = BluetoothRepositoryImpl(ble);
  final scanDevicesUseCase = ScanDevicesUseCase(repository);
  final connectToDeviceUseCase = ConnectToDeviceUseCase(repository);
  final disconnectDeviceUseCase = DisconnectDeviceUseCase(repository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BluetoothBloc(
            scanDevicesUseCase,
            connectToDeviceUseCase,
            disconnectDeviceUseCase,
          ),
        ),
      ],
      child: const BluetoothScannerApp(),
    ),
  );
}

class BluetoothScannerApp extends StatelessWidget {
  const BluetoothScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bluetooth Scanner',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BluetoothScannerScreen(),
    );
  }
}
