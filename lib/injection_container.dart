import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text_repeater/features/data/repositories/onboard/local/local_onboard_repository_impl.dart';
import 'package:text_repeater/features/domain/repositories/text/local/local_text_repository.dart';
import 'package:text_repeater/features/domain/usecases/text/local/create_word_cloud_usecase.dart';
import 'package:text_repeater/features/domain/usecases/text/local/get_saved_texts_usecase.dart';
import 'package:text_repeater/features/domain/usecases/text/local/randomize_text_usecase.dart';
import 'package:text_repeater/features/domain/usecases/text/local/repeat_text_usecase.dart';
import 'package:text_repeater/features/domain/usecases/text/local/reverse_text_usecase.dart';
import 'package:text_repeater/features/domain/usecases/text/local/sort_text_usecase.dart';
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
  sl.registerSingleton<RandomizeTextUsecase>(RandomizeTextUsecase(sl()));
  sl.registerSingleton<SortTextUsecase>(SortTextUsecase(sl()));
  sl.registerSingleton<ReverseTextUsecase>(ReverseTextUsecase(sl()));
  sl.registerSingleton<CreateWordCloudUseCase>(CreateWordCloudUseCase(sl()));
  sl.registerSingleton<GetSavedTextsUsecase>(GetSavedTextsUsecase(sl()));

  //Blocs
  sl.registerFactory<LocalOnboardBloc>(() => LocalOnboardBloc(sl(), sl()));
  sl.registerFactory<LocalTextBloc>(
      () => LocalTextBloc(sl(), sl(), sl(), sl(), sl(),sl()));
}
