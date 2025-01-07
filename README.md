# bluetooth_detector

A new Flutter project.
lib/
    |- main.dart
    |- core/
    |    |- dependency_injection.dart
    |- features/
            |- bluetooth/
                    |- data/
                    |    |- models/
                    |    |    |- bluetooth_device_model.dart
                    |    |- repositories/
                    |         |- bluetooth_repository_impl.dart
                    |- domain/
                    |    |- entities/
                    |    |    |- bluetooth_device_entity.dart
                    |    |- repositories/
                    |         |- bluetooth_repository.dart
                    |    |- usecases/
                    |         |- start_scan_usecase.dart
                    |         |- stop_scan_usecase.dart
                    |         |- connect_to_device_usecase.dart
                    |         |- disconnect_device_usecase.dart
                    |- presentation/
                        |- bloc/
                        |       |- bluetooth_bloc.dart
                        |       |- bluetooth_event.dart
                        |       |- bluetooth_state.dart
                        |- pages/
                                |- bluetooth_scanner_screen.dart
                                |- device_detail_page.dart

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
