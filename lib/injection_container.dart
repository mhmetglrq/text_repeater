import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text_repeater/features/data/repositories/local_onboard_repository_impl.dart';

import 'features/data/data_sources/local/hive_database_service.dart';
import 'features/domain/repositories/local_onboard_repository.dart';
import 'features/domain/usecases/get_onboard_status_usecase.dart';
import 'features/domain/usecases/save_onboard_status_usecase.dart';
import 'features/presentation/bloc/onboard/onboard_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  await Hive.initFlutter();
  // Dio
  // sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<HiveDatabaseService>(HiveDatabaseService.instance);

  sl.registerSingleton<LocalOnboardRepository>(
      LocalOnboardRepositoryImpl(sl()));

  //UseCases
  sl.registerSingleton<GetOnboardStatusUsecase>(GetOnboardStatusUsecase(sl()));
  sl.registerSingleton<SaveOnboardStatusUseCase>(
      SaveOnboardStatusUseCase(sl()));
      

  //Blocs
  sl.registerFactory<OnboardBloc>(() => OnboardBloc(sl(), sl()));
}
