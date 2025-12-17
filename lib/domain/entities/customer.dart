import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  final double lat;
  final double lng;
  final String address;

  const Customer({
    required this.lat,
    required this.lng,
    required this.address,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      address: json['address'] as String,
    );
  }

  @override
  List<Object> get props => [lat, lng, address];
}