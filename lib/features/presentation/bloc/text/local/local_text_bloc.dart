import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_repeater/features/domain/usecases/text/local/randomize_text_usecase.dart';
import 'package:text_repeater/features/domain/usecases/text/local/repeat_text_usecase.dart';

import '../../../../domain/usecases/text/local/sort_text_usecase.dart';

part 'local_text_event.dart';
part 'local_text_state.dart';

class LocalTextBloc extends Bloc<LocalTextEvent, LocalTextState> {
  final RepeatTextUsecase _repeatTextUsecase;
  final RandomizeTextUsecase _randomizeTextUsecase;
  final SortTextUsecase _sortTextUsecase;
  LocalTextBloc(this._repeatTextUsecase, this._randomizeTextUsecase,
      this._sortTextUsecase)
      : super(const LocalTextInitialState()) {
    on<RepeatTextEvent>(onRepeatText);
    on<RemoveTextEvent>(onRemoveText);
    on<RandomizeTextEvent>(onRandomizeText);
    on<SortTextEvent>(onSortingText);
  }

  void onRepeatText(RepeatTextEvent event, Emitter<LocalTextState> emit) async {
    emit(const LocalTextLoadingState());
    await _repeatTextUsecase(
            params: RepeatTextParams(
                text: event.text, times: event.times, newLine: event.newLine))
        .then((text) {
      emit(LocalTextSuccessState(text: text));
    }).catchError((error) {
      emit(LocalTextErrorState(message: error.toString()));
    });
  }

  void onRemoveText(RemoveTextEvent event, Emitter<LocalTextState> emit) {
    emit(const LocalTextInitialState());
  }

  void onRandomizeText(
      RandomizeTextEvent event, Emitter<LocalTextState> emit) async {
    emit(const LocalTextLoadingState());
    await _randomizeTextUsecase(params: RandomizeTextParams(text: event.text))
        .then((text) {
      emit(LocalTextSuccessState(text: text));
    }).catchError((error) {
      emit(LocalTextErrorState(message: error.toString()));
    });
  }

  void onSortingText(SortTextEvent event, Emitter<LocalTextState> emit) async {
    await _sortTextUsecase(params: event.text).then((text) {
      emit(LocalTextSuccessState(text: text));
    }).catchError((error) {
      emit(LocalTextErrorState(message: error.toString()));
    });
  }
}
