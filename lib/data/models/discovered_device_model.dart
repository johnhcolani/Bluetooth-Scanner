import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import '../../domain/entities/device_entity.dart';

class DiscoveredDeviceModel {
  final String id;
  final String name;
  final int rssi;

  DiscoveredDeviceModel({
    required this.id,
    required this.name,
    required this.rssi,
  });

  // Map from FlutterReactiveBle's DiscoveredDevice
  factory DiscoveredDeviceModel.fromReactiveBle(DiscoveredDevice device) {
    return DiscoveredDeviceModel(
      id: device.id,
      name: device.name,
      rssi: device.rssi,
    );
  }

  // Convert to domain entity
  DeviceEntity toEntity() {
    return DeviceEntity(
      id: id,
      name: name,
      rssi: rssi,
    );
  }
}
