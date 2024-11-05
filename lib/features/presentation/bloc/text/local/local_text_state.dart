part of 'local_text_bloc.dart';

sealed class LocalTextState extends Equatable {
  const LocalTextState(
      {this.text,
      this.message,
      this.wordCloudList,
      this.savedTexts,
      this.adCount});
  final String? text;
  final String? message;
  final List<Map<String, dynamic>>? wordCloudList;
  final List<TextModel>? savedTexts;
  final int? adCount;

  @override
  List<Object?> get props => [
        text,
        message,
        adCount,
      ];
}

final class LocalTextInitialState extends LocalTextState {
  const LocalTextInitialState({
    super.adCount = 0,
  });
}

final class LocalTextLoadingState extends LocalTextState {
  const LocalTextLoadingState(
    {
      super.adCount,
    }
  );
}

final class LocalTextSuccessState extends LocalTextState {
  const LocalTextSuccessState(
      {super.text, super.wordCloudList, super.savedTexts, super.adCount});
}

final class LocalTextErrorState extends LocalTextState {
  const LocalTextErrorState({super.message, super.adCount});
}

final class LocalTextSavedTextsLoadingState extends LocalTextState {
  const LocalTextSavedTextsLoadingState({super.savedTexts, super.adCount});
}

final class LocalTextSavedTextsSuccessState extends LocalTextState {
  const LocalTextSavedTextsSuccessState({super.savedTexts, super.adCount});
}

final class LocalTextSavedTextsErrorState extends LocalTextState {
  const LocalTextSavedTextsErrorState({super.message, super.adCount});
}
