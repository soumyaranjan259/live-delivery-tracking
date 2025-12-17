/*
import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:live_delivery_tracking/domain/entities/location_update.dart';
import 'package:live_delivery_tracking/domain/entities/order.dart';
import 'package:live_delivery_tracking/domain/usecases/get_order_usecase.dart';
import 'package:live_delivery_tracking/domain/usecases/start_tracking_usecase.dart';

import '../../../core/usecases/usecase.dart';

part 'tracking_event.dart';
part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final GetOrderUseCase getOrderUseCase;
  final StartTrackingUseCase startTrackingUseCase;
  StreamSubscription? _locationSubscription;

  TrackingBloc({
    required this.getOrderUseCase,
    required this.startTrackingUseCase,
  }) : super(TrackingInitial()) {
    on<StartTracking>(_onStartTracking);
    on<UpdateLocation>(_onUpdateLocation);
  }

  void _onStartTracking(StartTracking event, Emitter<TrackingState> emit) async {
    emit(TrackingLoading());

    final orderResult = await getOrderUseCase(NoParams());
    orderResult.fold(
          (failure) => emit(TrackingError('Failed to load order')),
          (order) async {
        final routePoints = order.route.map((u) => LatLng(u.lat, u.lng)).toList();

        emit(TrackingLoaded(
          order: order,
          route: routePoints,
          currentPosition: routePoints.first,
          currentIndex: 0,
          status: order.route.first.status,
          remainingDistance: _calculateRemainingDistance(0, order.route),
          eta: _calculateETA(0, order.route, order.route.first.speed),
          lastUpdated: DateTime.now(),
          speed: order.route.first.speed,
          heading: order.route.first.heading,
        ));

        final streamResult = await startTrackingUseCase(NoParams());
        streamResult.fold(
              (failure) => emit(TrackingError('Failed to start stream')),
              (stream) {
            _locationSubscription = stream.listen((update) => add(UpdateLocation(update)));
          },
        );
      },
    );
  }

  void _onUpdateLocation(UpdateLocation event, Emitter<TrackingState> emit) {
    if (state is TrackingLoaded) {
      final current = state as TrackingLoaded;
      final newIndex = current.currentIndex + 1;
      if (newIndex >= current.route.length) {
        _locationSubscription?.cancel();
        return;
      }

      final remaining = _calculateRemainingDistance(newIndex, current.order.route);
      final eta = _calculateETA(newIndex, current.order.route, event.update.speed);

      emit(TrackingLoaded(
        order: current.order,
        route: current.route,
        currentPosition: LatLng(event.update.lat, event.update.lng),
        currentIndex: newIndex,
        status: event.update.status,
        remainingDistance: remaining,
        eta: eta,
        lastUpdated: DateTime.now(),
        speed: event.update.speed,
        heading: event.update.heading,
      ));
    }
  }

  double _calculateRemainingDistance(int index, List<LocationUpdate> route) {
    double dist = 0;
    for (int i = index; i < route.length - 1; i++) {
      dist += Geolocator.distanceBetween(
        route[i].lat,
        route[i].lng,
        route[i + 1].lat,
        route[i + 1].lng,
      );
    }
    return dist;
  }

  int _calculateETA(int index, List<LocationUpdate> route, double speed) {
    if (speed <= 0) return 0;
    final distMeters = _calculateRemainingDistance(index, route);
    final hours = (distMeters / 1000) / speed;
    return (hours * 60).round();
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}*/

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:live_delivery_tracking/domain/entities/location_update.dart';
import 'package:live_delivery_tracking/domain/entities/order.dart';
import 'package:live_delivery_tracking/domain/usecases/get_order_usecase.dart';
import 'package:live_delivery_tracking/domain/usecases/start_tracking_usecase.dart';
import '../../../core/usecases/usecase.dart';

part 'tracking_event.dart';
part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final GetOrderUseCase getOrderUseCase;
  final StartTrackingUseCase startTrackingUseCase;
  StreamSubscription? _locationSubscription;

  TrackingBloc({
    required this.getOrderUseCase,
    required this.startTrackingUseCase,
  }) : super(TrackingInitial()) {
    on<StartTracking>(_onStartTracking);
    on<UpdateLocation>(_onUpdateLocation);
  }

  void _onStartTracking(StartTracking event, Emitter<TrackingState> emit) async {
    emit(TrackingLoading());

    final orderResult = await getOrderUseCase(NoParams());
    orderResult.fold(
          (failure) => emit(TrackingError('Failed to load order')),
          (order) async {
        final routePoints = order.route.map((u) => LatLng(u.lat, u.lng)).toList();

        emit(TrackingLoaded(
          order: order,
          route: routePoints,
          currentPosition: routePoints.first,
          currentIndex: 0,
          status: order.route.first.status,
          remainingDistance: _calculateRemainingDistance(0, order.route),
          eta: _calculateETA(0, order.route),
          lastUpdated: DateTime.now(),
          speed: order.route.first.speed,
          heading: order.route.first.heading,
        ));

        final streamResult = await startTrackingUseCase(NoParams());
        streamResult.fold(
              (failure) => emit(TrackingError('Failed to start tracking')),
              (stream) {
            _locationSubscription = stream.listen((update) => add(UpdateLocation(update)));
          },
        );
      },
    );
  }

  void _onUpdateLocation(UpdateLocation event, Emitter<TrackingState> emit) {
    if (state is TrackingLoaded) {
      final current = state as TrackingLoaded;
      final newIndex = current.currentIndex + 1;

      if (newIndex >= current.route.length) {
        _locationSubscription?.cancel();
        return;
      }

      String status = event.update.status; // Use from stream
      // Override with exact required logic
      if (newIndex == 0) status = "picked";
      else if (newIndex < 5) status = "en_route";
      else if (newIndex < 8) status = "arriving";
      else status = "delivered";

      final remaining = _calculateRemainingDistance(newIndex, current.order.route);
      final eta = _calculateETA(newIndex, current.order.route);

      emit(TrackingLoaded(
        order: current.order,
        route: current.route,
        currentPosition: LatLng(event.update.lat, event.update.lng),
        currentIndex: newIndex,
        status: status,
        remainingDistance: remaining,
        eta: eta,
        lastUpdated: DateTime.now(),
        speed: event.update.speed,
        heading: event.update.heading,
      ));
    }
  }

  double _calculateRemainingDistance(int index, List<LocationUpdate> route) {
    double total = 0.0;
    for (int i = index; i < route.length - 1; i++) {
      total += Geolocator.distanceBetween(
        route[i].lat, route[i].lng,
        route[i + 1].lat, route[i + 1].lng,
      );
    }
    return total / 1000; // km
  }

  int _calculateETA(int index, List<LocationUpdate> route) {
    final distKm = _calculateRemainingDistance(index, route);
    if (distKm == 0) return 0;
    return (distKm * 2).round(); // ~30 km/h average
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}