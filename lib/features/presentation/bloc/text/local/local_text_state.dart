part of 'local_text_bloc.dart';

sealed class LocalTextState extends Equatable {
  const LocalTextState(
      {this.text, this.message, this.wordCloudList, this.savedTexts});
  final String? text;
  final String? message;
  final List<Map<String, dynamic>>? wordCloudList;
  final List<TextModel>? savedTexts;

  @override
  List<Object?> get props => [
        text,
        message,
      ];
}

final class LocalTextInitialState extends LocalTextState {
  const LocalTextInitialState();
}

final class LocalTextLoadingState extends LocalTextState {
  const LocalTextLoadingState();
}

final class LocalTextSuccessState extends LocalTextState {
  const LocalTextSuccessState(
      {super.text, super.wordCloudList, super.savedTexts});
}

final class LocalTextErrorState extends LocalTextState {
  const LocalTextErrorState({super.message});
}

final class LocalTextSavedTextsLoadingState extends LocalTextState {
  const LocalTextSavedTextsLoadingState({super.savedTexts});
}

final class LocalTextSavedTextsSuccessState extends LocalTextState {
  const LocalTextSavedTextsSuccessState({super.savedTexts});
}

final class LocalTextSavedTextsErrorState extends LocalTextState {
  const LocalTextSavedTextsErrorState({super.message});
}
