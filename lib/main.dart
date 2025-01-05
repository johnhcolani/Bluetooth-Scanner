import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'bluetooth_scanner_screen.dart';
import 'device_detail_page.dart';

void main() {
  runApp(const BluetoothScannerApp());
}

class BluetoothScannerApp extends StatelessWidget {
  const BluetoothScannerApp({Key? key}) : super(key: key);

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

