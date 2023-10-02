class TrailsModel {
  String? name;
  String? distance;
  String? decent;
  String? ascent;
  String? difficulty;
  String? coordinates;

  TrailsModel(
      {this.name,
      this.distance,
      this.decent,
      this.ascent,
      this.difficulty,
      this.coordinates});

  TrailsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    distance = json['distance'];
    decent = json['decent'];
    ascent = json['ascent'];
    difficulty = json['difficulty'];
    coordinates = json['coordinates'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['distance'] = distance;
    data['decent'] = decent;
    data['ascent'] = ascent;
    data['difficulty'] = difficulty;
    data['coordinates'] = coordinates;
    return data;
  }
}
