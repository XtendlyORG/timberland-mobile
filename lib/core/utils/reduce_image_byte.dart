import 'dart:typed_data';

import 'package:image/image.dart' as img;

Future<List<int>> reduceImageByte(
  Uint8List imageByte, {
  double minimumSize = 512,
}) async {
  final image = img.decodeImage(imageByte);
  int reducedWidth = image?.width ?? 0 ~/ 3;

  return img.encodePng(
    img.copyResize(
      image!,
      width: reducedWidth > minimumSize
          ? minimumSize.toInt()
          : reducedWidth.toInt(),
    ),
  );
}
