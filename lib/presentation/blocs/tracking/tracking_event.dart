part of 'tracking_bloc.dart';

abstract class TrackingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartTracking extends TrackingEvent {}

class UpdateLocation extends TrackingEvent {
  final LocationUpdate update;
  UpdateLocation(this.update);
  @override
  List<Object> get props => [update];
}