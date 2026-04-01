import 'package:permission_handler/permission_handler.dart';

Future<void> requestAllPermissions() async {
  // Demander les permissions de stockage
  await Permission.storage.request();

  // Demander les permissions Bluetooth (Android 12+)
  await Permission.bluetooth.request();
  await Permission.bluetoothScan.request();
  await Permission.bluetoothConnect.request();

  // Demander la permission de localisation (nécessaire pour le Bluetooth)
  await Permission.location.request();

  // Vérifier les permissions
  final storageGranted = await Permission.storage.isGranted;
  final bluetoothGranted =
      await Permission.bluetooth.isGranted &&
      await Permission.bluetoothScan.isGranted &&
      await Permission.bluetoothConnect.isGranted;
  final locationGranted = await Permission.location.isGranted;

  if (storageGranted && bluetoothGranted && locationGranted) {
    print("Toutes les permissions sont accordées !");
  } else {
    print("Certaines permissions sont refusées.");
  }
}
