import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<String> getPhotoDirectory(String directory) async {
  final dir = Platform.isAndroid
      ? Directory('storage/emulated/0/Pictures/$directory')
      : Directory(
          '${(await getApplicationDocumentsDirectory()).path}Pictures/$directory',
        );
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
