import 'package:dartz/dartz.dart' as dartz;
import 'package:live_delivery_tracking/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<dartz.Either<Failure, Type>> call(Params params);
}

class NoParams {}