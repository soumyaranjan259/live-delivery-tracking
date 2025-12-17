import 'package:dartz/dartz.dart' as dartz;
import 'package:live_delivery_tracking/core/error/failures.dart';
import 'package:live_delivery_tracking/core/usecases/usecase.dart';
import 'package:live_delivery_tracking/domain/entities/order.dart';
import 'package:live_delivery_tracking/domain/repositories/tracking_repository.dart';

class GetOrderUseCase extends UseCase<Order, NoParams> {
  final TrackingRepository repository;

  GetOrderUseCase(this.repository);

  @override
  Future<dartz.Either<Failure, Order>> call(NoParams params) => repository.getOrder();
}