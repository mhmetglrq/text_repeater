import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/onboard/local/get_onboard_status_usecase.dart';
import '../../../../domain/usecases/onboard/local/save_onboard_status_usecase.dart';

import 'package:equatable/equatable.dart';

part 'local_onboard_state.dart';
part 'local_onboard_event.dart';

class LocalOnboardBloc extends Bloc<LocalOnboardEvent, LocalOnboardState> {
  final GetOnboardStatusUsecase _getOnboardStatusUsecase;
  final SaveOnboardStatusUseCase _saveOnboardStatusUseCase;

  LocalOnboardBloc(
    this._getOnboardStatusUsecase,
    this._saveOnboardStatusUseCase,
  ) : super(const OnboardInitialState()) {
    on<GetOnboardStatusEvent>(onGetOnBoardStatus);
    on<SaveOnboardStatusEvent>(onSaveOnBoardStatus);
  }

  void onGetOnBoardStatus(
      GetOnboardStatusEvent event, Emitter<LocalOnboardState> emit) async {
    emit(const OnboardLoadingState());
    await _getOnboardStatusUsecase().then((status) {
      emit(OnboardSuccessState(status: status));
    }).catchError((error) {
      emit(OnboardErrorState(error.toString()));
    });
  }

  void onSaveOnBoardStatus(
      SaveOnboardStatusEvent event, Emitter<LocalOnboardState> emit) async {
    await _saveOnboardStatusUseCase(
      params: event.status,
    ).then((_) {
      emit(OnboardSuccessState(status: state.status));
    }).catchError((error) {
      emit(OnboardErrorState(error.toString()));
    });
  }
}
