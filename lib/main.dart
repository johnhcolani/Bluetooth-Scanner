import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/dependency_injection.dart' as di;
import 'features/bluetooth/presentation/bloc/bluetooth_bloc.dart';
import 'features/bluetooth/presentation/screens/bluetooth_scanner_screen.dart';

void main() {
  di.init(); // Initialize dependency injection
  runApp(const BluetoothScannerApp());
}

class BluetoothScannerApp extends StatelessWidget {
  const BluetoothScannerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<BluetoothBloc>(), // Inject BluetoothBloc globally
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bluetooth Scanner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BluetoothScannerScreen(),
      ),
    );
  }
}
