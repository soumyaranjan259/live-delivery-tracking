import 'package:dartz/dartz.dart' as dartz;
import 'package:live_delivery_tracking/core/error/failures.dart';
import 'package:live_delivery_tracking/core/usecases/usecase.dart';
import 'package:live_delivery_tracking/domain/entities/location_update.dart';
import 'package:live_delivery_tracking/domain/repositories/tracking_repository.dart';

class StartTrackingUseCase extends UseCase<Stream<LocationUpdate>, NoParams> {
  final TrackingRepository repository;

  StartTrackingUseCase(this.repository);

  @override
  Future<dartz.Either<Failure, Stream<LocationUpdate>>> call(NoParams params) =>
      repository.getLocationStream();
}