class UserGeoModel {
  final String lat;
  final String lng;

  UserGeoModel({required this.lat, required this.lng});

  factory UserGeoModel.fromJson(Map<String, dynamic> json) {
    return UserGeoModel(
      lat: json['lat']?.toString() ?? '0.0',
      lng: json['lng']?.toString() ?? '0.0',
    );
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lng': lng};
  }
}
