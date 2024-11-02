import 'package:get_it/get_it.dart';
import 'package:voiceline/data/repositories/classifier_repository.dart';
import 'package:voiceline/data/repositories/image_repository.dart';
import 'package:voiceline/data/sources/remote/image_data_source.dart';
import 'package:voiceline/domain/usecases/classifier/classifier_use_case.dart';
import 'package:voiceline/domain/usecases/image/image_use_case.dart';
import 'package:voiceline/presentation/cubits/prediction_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupInjection() {
  getIt
  // Cubits & BloCs
    ..registerFactory(() => PredictionCubit(getIt<ImageUseCase>(), getIt<ClassifierUseCase>()))
  // Use cases
    ..registerFactory(() => ImageUseCase(getIt<ImageRepository>()))
    ..registerFactory(() => ClassifierUseCase(getIt<ClassifierRepository>()))
  // Repositories
    ..registerLazySingleton(() => ImageRepository(getIt<ImageDataSource>()))
    ..registerLazySingleton(() => ClassifierRepository())
  // Data sources
    ..registerLazySingleton(() => ImageDataSource());
}