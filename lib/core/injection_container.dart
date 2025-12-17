import 'package:get_it/get_it.dart';
import 'package:live_delivery_tracking/data/datasources/mock_datasource.dart';
import 'package:live_delivery_tracking/data/repositories/tracking_repository_impl.dart';
import 'package:live_delivery_tracking/domain/repositories/tracking_repository.dart';
import 'package:live_delivery_tracking/domain/usecases/get_order_usecase.dart';
import 'package:live_delivery_tracking/domain/usecases/start_tracking_usecase.dart';
import 'package:live_delivery_tracking/presentation/blocs/tracking/tracking_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => TrackingBloc(
    getOrderUseCase: sl(),
    startTrackingUseCase: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => GetOrderUseCase(sl()));
  sl.registerLazySingleton(() => StartTrackingUseCase(sl()));

  // Repository
  sl.registerLazySingleton<TrackingRepository>(() => TrackingRepositoryImpl(mockDataSource: sl()));

  // Data source
  sl.registerLazySingleton<MockDataSource>(() => MockDataSourceImpl());
}