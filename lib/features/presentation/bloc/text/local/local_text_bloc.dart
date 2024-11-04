import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_repeater/features/domain/usecases/text/local/create_word_cloud_usecase.dart';
import 'package:text_repeater/features/domain/usecases/text/local/randomize_text_usecase.dart';
import 'package:text_repeater/features/domain/usecases/text/local/repeat_text_usecase.dart';
import 'package:text_repeater/features/domain/usecases/text/local/reverse_text_usecase.dart';

import '../../../../../config/models/text_model.dart';
import '../../../../domain/usecases/text/local/get_saved_texts_usecase.dart';
import '../../../../domain/usecases/text/local/sort_text_usecase.dart';

part 'local_text_event.dart';
part 'local_text_state.dart';

class LocalTextBloc extends Bloc<LocalTextEvent, LocalTextState> {
  final RepeatTextUsecase _repeatTextUsecase;
  final RandomizeTextUsecase _randomizeTextUsecase;
  final SortTextUsecase _sortTextUsecase;
  final ReverseTextUsecase _reverseTextUsecase;
  final CreateWordCloudUseCase _createWordCloudUseCase;
  final GetSavedTextsUsecase _getSavedTextsUsecase;
  LocalTextBloc(
    this._repeatTextUsecase,
    this._randomizeTextUsecase,
    this._sortTextUsecase,
    this._reverseTextUsecase,
    this._createWordCloudUseCase,
    this._getSavedTextsUsecase,
  ) : super(const LocalTextInitialState()) {
    on<RepeatTextEvent>(onRepeatText);
    on<RemoveTextEvent>(onRemoveText);
    on<RandomizeTextEvent>(onRandomizeText);
    on<SortTextEvent>(onSortingText);
    on<ReverseTextEvent>(onReverseText);
    on<WordCloudEvent>(onCreateWordCloud);
    on<GetSavedTextsEvent>(onGetSavedTexts);
  }

  void onRepeatText(RepeatTextEvent event, Emitter<LocalTextState> emit) async {
    emit(const LocalTextLoadingState());
    await _repeatTextUsecase(
            params: RepeatTextParams(
                text: event.text, times: event.times, newLine: event.newLine))
        .then((text) {
      emit(LocalTextSuccessState(text: text, savedTexts: state.savedTexts));
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
    emit(const LocalTextLoadingState());
    await _sortTextUsecase(params: event.text).then((text) {
      emit(LocalTextSuccessState(text: text));
    }).catchError((error) {
      emit(LocalTextErrorState(message: error.toString()));
    });
  }

  void onReverseText(
      ReverseTextEvent event, Emitter<LocalTextState> emit) async {
    emit(const LocalTextLoadingState());
    await _reverseTextUsecase(params: event.text).then((text) {
      emit(LocalTextSuccessState(text: text));
    }).catchError((error) {
      emit(LocalTextErrorState(message: error.toString()));
    });
  }

  void onCreateWordCloud(
      WordCloudEvent event, Emitter<LocalTextState> emit) async {
    emit(const LocalTextLoadingState());
    await _createWordCloudUseCase(params: event.text).then((wordCloudList) {
      emit(LocalTextSuccessState(wordCloudList: wordCloudList));
    }).catchError((error) {
      emit(LocalTextErrorState(message: error.toString()));
    });
  }

  void onGetSavedTexts(
      GetSavedTextsEvent event, Emitter<LocalTextState> emit) async {
    emit(const LocalTextSavedTextsLoadingState());
    await _getSavedTextsUsecase().then((savedTexts) {
      emit(LocalTextSavedTextsSuccessState(
        savedTexts: savedTexts.reversed.toList(),
      ));
    }).catchError((error) {
      emit(LocalTextSavedTextsErrorState(message: error.toString()));
    });
  }
}
