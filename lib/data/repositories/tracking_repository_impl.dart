import 'package:dartz/dartz.dart' as dartz;
import 'package:live_delivery_tracking/core/error/failures.dart';
import 'package:live_delivery_tracking/data/datasources/mock_datasource.dart';
import 'package:live_delivery_tracking/domain/entities/location_update.dart';
import 'package:live_delivery_tracking/domain/entities/order.dart';
import 'package:live_delivery_tracking/domain/repositories/tracking_repository.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final MockDataSource mockDataSource;

  TrackingRepositoryImpl({required this.mockDataSource});

  @override
  Future<dartz.Either<Failure, Order>> getOrder() async {
    try {
      final order = await mockDataSource.getOrder();
      return dartz.Right(order);
    } catch (e) {
      return dartz.Left(CacheFailure());
    }
  }

  @override
  Future<dartz.Either<Failure, Stream<LocationUpdate>>> getLocationStream() async {
    try {
      final stream = mockDataSource.getLocationStream();
      return dartz.Right(stream);
    } catch (e) {
      return dartz.Left(ServerFailure());
    }
  }
}