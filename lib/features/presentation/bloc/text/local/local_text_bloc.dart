import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_repeater/features/domain/usecases/text/local/repeat_text_usecase.dart';

part 'local_text_event.dart';
part 'local_text_state.dart';

class LocalTextBloc extends Bloc<LocalTextEvent, LocalTextState> {
  final RepeatTextUsecase _repeatTextUsecase;
  LocalTextBloc(this._repeatTextUsecase)
      : super(const LocalTextInitialState()) {
    on<RepeatTextEvent>(onRepeatText);
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
}
