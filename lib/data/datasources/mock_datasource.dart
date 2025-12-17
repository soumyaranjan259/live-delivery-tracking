/*
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:live_delivery_tracking/domain/entities/location_update.dart';
import 'package:live_delivery_tracking/domain/entities/order.dart';

abstract class MockDataSource {
  Future<Order> getOrder();
  Stream<LocationUpdate> getLocationStream();
}

class MockDataSourceImpl implements MockDataSource {
  @override
  Future<Order> getOrder() async {
    final jsonString = await rootBundle.loadString('assets/mock/route_hyd.json');
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    return Order.fromJson(jsonMap);
  }

  @override
  Stream<LocationUpdate> getLocationStream() async* {
    final order = await getOrder();
    for (final update in order.route) {
      await Future.delayed(const Duration(seconds: 2));
      yield update;
    }
  }
}*/


import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/entities/location_update.dart';
import '../../domain/entities/order.dart';
abstract class MockDataSource {
  Future<Order> getOrder();
  Stream<LocationUpdate> getLocationStream();
}

class MockDataSourceImpl implements MockDataSource {
  @override
  Future<Order> getOrder() async {
    final jsonString = await rootBundle.loadString('assets/mock/route_hyd.json');
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    return Order.fromJson(jsonMap);
  }

  @override
  Stream<LocationUpdate> getLocationStream() async* {
    final order = await getOrder();
    for (final update in order.route) {
      await Future.delayed(const Duration(seconds: 2));
      yield update;
    }
  }
}