import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_onboard_status_usecase.dart';
import '../../../domain/usecases/save_onboard_status_usecase.dart';

import 'package:equatable/equatable.dart';

part 'onboard_state.dart';
part 'onboard_event.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  final GetOnboardStatusUsecase _getOnboardStatusUsecase;
  final SaveOnboardStatusUseCase _saveOnboardStatusUseCase;

  OnboardBloc(this._getOnboardStatusUsecase, this._saveOnboardStatusUseCase)
      : super(const OnboardInitialState()) {
    on<GetOnboardStatusEvent>(onGetOnBoardStatus);
    on<SaveOnboardStatusEvent>(onSaveOnBoardStatus);
  }

  void onGetOnBoardStatus(
      GetOnboardStatusEvent event, Emitter<OnboardState> emit) async {
    emit(const OnboardLoadingState());
    await _getOnboardStatusUsecase().then((status) {
      emit(OnboardSuccessState(status: status));
    }).catchError((error) {
      emit(OnboardErrorState(error.toString()));
    });
  }

  void onSaveOnBoardStatus(
      SaveOnboardStatusEvent event, Emitter<OnboardState> emit) async {
    await _saveOnboardStatusUseCase(
      params: event.status,
    ).then((_) {
      emit(OnboardSuccessState(status: state.status));
    }).catchError((error) {
      emit(OnboardErrorState(error.toString()));
    });
  }
}
