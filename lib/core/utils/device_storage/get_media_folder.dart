import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

Future<String> getPhotoDirectory(String directory) async {
  final dir = Directory('storage/emulated/0/Pictures/$directory');
  final status = await Permission.manageExternalStorage.status;
  if (!status.isGranted && !status.isRestricted) {
    await Permission.manageExternalStorage.request();
  } else if (status.isRestricted) {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }
  if ((await dir.exists())) {
    return dir.path;
  } else {
    await dir.create(recursive: true);
    return dir.path;
  }
}
