class VehicleMarker {
  var heading;
  var latitude;
  var longitude;

  VehicleMarker({
    required this.heading,
    required this.latitude,
    required this.longitude,
  });

  factory VehicleMarker.fromJson(Map<String, dynamic> json) {
    return VehicleMarker(
      heading: json['heading'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
