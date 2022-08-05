import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<File> createFileFromAsset(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  File file = await File(
    '${(await getApplicationDocumentsDirectory()).path}/$assetPath',
  ).create(recursive: true);

  return await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
}
