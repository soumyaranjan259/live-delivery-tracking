import 'package:dartz/dartz.dart' as dartz;
import 'package:live_delivery_tracking/core/error/failures.dart';
import 'package:live_delivery_tracking/domain/entities/location_update.dart';
import 'package:live_delivery_tracking/domain/entities/order.dart';

abstract class TrackingRepository {
  Future<dartz.Either<Failure, Order>> getOrder();
  Future<dartz.Either<Failure, Stream<LocationUpdate>>> getLocationStream();
}