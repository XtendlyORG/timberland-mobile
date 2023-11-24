class FeaturedImage {
  String filename;
  String path;

  FeaturedImage({
    required this.filename,
    required this.path,
  });

  //from json
  factory FeaturedImage.fromJson(Map<String, dynamic> json) => FeaturedImage(
        filename: json['filename'],
        path: json['path'],
      );

  //to json
  Map<String, dynamic> toJson() => {
        'filename': filename,
        'path': path,
      };
}
