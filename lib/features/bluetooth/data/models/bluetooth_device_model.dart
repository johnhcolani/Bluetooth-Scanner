import '../../domain/entities/bluetooth_device_entity.dart';

class BluetoothDeviceModel {
  final String id;
  final String name;
  final int rssi;

  BluetoothDeviceModel({
    required this.id,
    required this.name,
    required this.rssi,
  });

  // Factory constructor to create a model from raw BLE data
  factory BluetoothDeviceModel.fromRawData({
    required String id,
    required String name,
    required int rssi,
  }) {
    return BluetoothDeviceModel(
      id: id,
      name: name.isEmpty ? "Unknown Device" : name,
      rssi: rssi,
    );
  }
  // Convert model to entity
  BluetoothDeviceEntity toEntity() {
    return BluetoothDeviceEntity(
      id: id,
      name: name,
      rssi: rssi,
    );
  }
}