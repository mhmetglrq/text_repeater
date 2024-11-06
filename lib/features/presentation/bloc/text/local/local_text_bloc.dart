import 'dart:developer';

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
  ) : super(const LocalTextInitialState(
          adCount: 0,
        )) {
    on<RepeatTextEvent>(onRepeatText);
    on<RemoveTextEvent>(onRemoveText);
    on<RandomizeTextEvent>(onRandomizeText);
    on<SortTextEvent>(onSortingText);
    on<ReverseTextEvent>(onReverseText);
    on<WordCloudEvent>(onCreateWordCloud);
    on<GetSavedTextsEvent>(onGetSavedTexts);
    on<IncrementAdCountEvent>(onIncrementAdCount);
  }

  void onRepeatText(RepeatTextEvent event, Emitter<LocalTextState> emit) async {
    emit(LocalTextLoadingState(
      adCount: state.adCount,
    ));

    await _repeatTextUsecase(
            params: RepeatTextParams(
                text: event.text!,
                times: event.times,
                newLine: event.newLine,
                isRecent: event.isRecent))
        .then((text) {
      emit(
        LocalTextSuccessState(
          text: text,
          savedTexts: state.savedTexts,
          adCount: state.adCount,
        ),
      );
    }).catchError((error) {
      emit(LocalTextErrorState(message: error.toString()));
    });
  }

  void onRemoveText(RemoveTextEvent event, Emitter<LocalTextState> emit) {
    emit(LocalTextInitialState(
      adCount: state.adCount,
    ));
  }

  void onRandomizeText(
      RandomizeTextEvent event, Emitter<LocalTextState> emit) async {
    emit(LocalTextLoadingState(
      adCount: state.adCount,
    ));

    await _randomizeTextUsecase(
        params: RandomizeTextParams(
      text: event.text!,
      isRecent: event.isRecent,
    )).then((text) {
      emit(
        LocalTextSuccessState(
          text: text,
          adCount: state.adCount,
        ),
      );
    }).catchError((error) {
      emit(LocalTextErrorState(message: error.toString()));
    });
  }

  void onSortingText(SortTextEvent event, Emitter<LocalTextState> emit) async {
    emit(LocalTextLoadingState(
      adCount: state.adCount,
    ));

    await _sortTextUsecase(
            params: SortTextParams(text: event.text!, isRecent: event.isRecent))
        .then((text) {
      emit(
        LocalTextSuccessState(
          text: text,
          adCount: state.adCount,
        ),
      );
    }).catchError((error) {
      emit(LocalTextErrorState(message: error.toString()));
    });
  }

  void onReverseText(
      ReverseTextEvent event, Emitter<LocalTextState> emit) async {
    emit(LocalTextLoadingState(
      adCount: state.adCount,
    ));

    await _reverseTextUsecase(
            params:
                ReverseTextParams(text: event.text!, isRecent: event.isRecent))
        .then((text) {
      emit(
        LocalTextSuccessState(
          text: text,
          adCount: state.adCount,
        ),
      );
    }).catchError((error) {
      emit(LocalTextErrorState(message: error.toString()));
    });
  }

  void onCreateWordCloud(
      WordCloudEvent event, Emitter<LocalTextState> emit) async {
    emit(LocalTextLoadingState(
      adCount: state.adCount,
    ));

    await _createWordCloudUseCase(
      params: CreateWordCloudUseCaseParams(
        text: event.text!,
        isRecent: event.isRecent,
      ),
    ).then((wordCloudList) {
      emit(
        LocalTextSuccessState(
          wordCloudList: wordCloudList,
          adCount: state.adCount,
        ),
      );
    }).catchError((error) {
      emit(LocalTextErrorState(message: error.toString()));
    });
  }

  void onGetSavedTexts(
      GetSavedTextsEvent event, Emitter<LocalTextState> emit) async {
    emit(LocalTextSavedTextsLoadingState(
      adCount: state.adCount,
    ));
    await _getSavedTextsUsecase().then((savedTexts) {
      emit(LocalTextSavedTextsSuccessState(
        savedTexts: savedTexts.reversed.toList(),
      ));
    }).catchError((error) {
      emit(LocalTextSavedTextsErrorState(message: error.toString()));
    });
  }

  void onIncrementAdCount(
      IncrementAdCountEvent event, Emitter<LocalTextState> emit) {
    if (event.adCount != null) {
      emit(LocalTextSuccessState(
        adCount: event.adCount,
        text: state.text,
        savedTexts: state.savedTexts,
      ));
      return;
    }
    int adCount = state.adCount ?? 0;
    adCount++;

    emit(LocalTextSuccessState(
        adCount: adCount, text: state.text, savedTexts: state.savedTexts));
    log("Ad count 2: $adCount");
  }
}
