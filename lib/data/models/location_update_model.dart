import 'package:equatable/equatable.dart';

class LocationUpdate extends Equatable {
  final double lat;
  final double lng;
  final double speed;
  final double heading;
  final String status;

  const LocationUpdate({
    required this.lat,
    required this.lng,
    required this.speed,
    required this.heading,
    required this.status,
  });

  factory LocationUpdate.fromJson(Map<String, dynamic> json) {
    return LocationUpdate(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      speed: (json['speed'] as num).toDouble(),
      heading: (json['heading'] as num).toDouble(),
      status: json['status'] as String,
    );
  }

  @override
  List<Object> get props => [lat, lng, speed, heading, status];
}