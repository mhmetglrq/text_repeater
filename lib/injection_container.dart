import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text_repeater/features/data/repositories/onboard/local/local_onboard_repository_impl.dart';
import 'package:text_repeater/features/domain/repositories/text/local/local_text_repository.dart';
import 'package:text_repeater/features/domain/usecases/text/local/repeat_text_usecase.dart';
import 'package:text_repeater/features/presentation/bloc/text/local/local_text_bloc.dart';

import 'config/models/text_model.dart';
import 'features/data/data_sources/local/hive_database_service.dart';
import 'features/data/repositories/text/local/local_text_repository_impl.dart';
import 'features/domain/repositories/onboard/local/local_onboard_repository.dart';
import 'features/domain/usecases/onboard/local/get_onboard_status_usecase.dart';
import 'features/domain/usecases/onboard/local/save_onboard_status_usecase.dart';
import 'features/presentation/bloc/onboard/local/local_onboard_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  await Hive.initFlutter();
  // Dio
  // sl.registerSingleton<Dio>(Dio());
  Hive.registerAdapter(TextModelAdapter());
  sl.registerSingleton<HiveDatabaseService>(HiveDatabaseService.instance);

  sl.registerSingleton<LocalOnboardRepository>(
      LocalOnboardRepositoryImpl(sl()));
  sl.registerSingleton<LocalTextRepository>(LocalTextRepositoryImpl(sl()));

  //UseCases
  sl.registerSingleton<GetOnboardStatusUsecase>(GetOnboardStatusUsecase(sl()));
  sl.registerSingleton<SaveOnboardStatusUseCase>(
      SaveOnboardStatusUseCase(sl()));
  sl.registerSingleton<RepeatTextUsecase>(RepeatTextUsecase(sl()));

  //Blocs
  sl.registerFactory<LocalOnboardBloc>(() => LocalOnboardBloc(sl(), sl()));
  sl.registerFactory<LocalTextBloc>(() => LocalTextBloc(sl()));
}
