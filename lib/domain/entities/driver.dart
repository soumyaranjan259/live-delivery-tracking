import 'package:equatable/equatable.dart';

class Driver extends Equatable {
  final String id;
  final String name;
  final String vehicle;
  final String phone;

  const Driver({
    required this.id,
    required this.name,
    required this.vehicle,
    required this.phone,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] as String,
      name: json['name'] as String,
      vehicle: json['vehicle'] as String,
      phone: json['phone'] as String,
    );
  }

  @override
  List<Object> get props => [id, name, vehicle, phone];
}