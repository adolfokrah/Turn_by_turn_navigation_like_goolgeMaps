///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class DirectionModelDistance {
/*
{
  "lat": 51.1797473,
  "lng": 6.8273933
} 
*/

  double? lat;
  double? lng;

  DirectionModelDistance({
    this.lat,
    this.lng,
  });
  DirectionModelDistance.fromJson(Map<String, dynamic> json) {
    lat = json['lat']?.toDouble();
    lng = json['lng']?.toDouble();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class DirectionModel {
/*
{
  "instructions": "Head <b>southwest</b> toward <b>Kölner Landstraße</b><div style=\"font-size:0.9em\">Restricted usage road</div>",
  "distance": {
    "lat": 51.1797473,
    "lng": 6.8273933
  }
} 
*/

  String? instructions;
  DirectionModelDistance? distance;

  DirectionModel({
    this.instructions,
    this.distance,
  });
  DirectionModel.fromJson(Map<String, dynamic> json) {
    instructions = json['instructions']?.toString();
    distance = (json['distance'] != null) ? DirectionModelDistance.fromJson(json['distance']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['instructions'] = instructions;
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    return data;
  }
}