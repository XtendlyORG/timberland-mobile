import 'dart:typed_data';

import 'package:image/image.dart' as img;

Future<List<int>> reduceImageByte(
  Uint8List imageByte, {
  double minimumSize = 2048,
}) async {
  final image = img.decodeImage(imageByte);
  int reducedWidth = image?.width ?? 0 ~/ 3;

  return img.encodePng(
    img.copyResize(
      image!,
      interpolation: img.Interpolation.average,
      width: reducedWidth > minimumSize
          ? minimumSize.toInt()
          : reducedWidth.toInt(),
    ),
  );
}
