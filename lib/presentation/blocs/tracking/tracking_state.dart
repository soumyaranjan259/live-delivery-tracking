part of 'tracking_bloc.dart';

abstract class TrackingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrackingInitial extends TrackingState {}

class TrackingLoading extends TrackingState {}

class TrackingLoaded extends TrackingState {
  final Order order;
  final List<LatLng> route;
  final LatLng currentPosition;
  final int currentIndex;
  final String status;
  final double remainingDistance;
  final int eta;
  final DateTime lastUpdated;
  final double speed;
  final double heading;

  TrackingLoaded({
    required this.order,
    required this.route,
    required this.currentPosition,
    required this.currentIndex,
    required this.status,
    required this.remainingDistance,
    required this.eta,
    required this.lastUpdated,
    required this.speed,
    required this.heading,
  });

  @override
  List<Object?> get props => [
    order,
    route,
    currentPosition,
    currentIndex,
    status,
    remainingDistance,
    eta,
    lastUpdated,
    speed,
    heading,
  ];
}

class TrackingError extends TrackingState {
  final String message;
  TrackingError(this.message);
  @override
  List<Object?> get props => [message];
}