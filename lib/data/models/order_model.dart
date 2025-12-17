import 'package:equatable/equatable.dart';
import 'package:live_delivery_tracking/domain/entities/customer.dart';
import 'package:live_delivery_tracking/domain/entities/driver.dart';
import 'package:live_delivery_tracking/domain/entities/location_update.dart';

class Order extends Equatable {
  final String orderId;
  final Driver driver;
  final Customer customer;
  final List<LocationUpdate> route;

  const Order({
    required this.orderId,
    required this.driver,
    required this.customer,
    required this.route,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'] as String,
      driver: Driver.fromJson(json['driver'] as Map<String, dynamic>),
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      route: (json['route'] as List)
          .map((e) => LocationUpdate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object> get props => [orderId, driver, customer, route];
}