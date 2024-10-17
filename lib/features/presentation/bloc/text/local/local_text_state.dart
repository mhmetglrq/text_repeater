part of 'local_text_bloc.dart';

sealed class LocalTextState extends Equatable {
  const LocalTextState({this.text, this.message});
  final String? text;
  final String? message;

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
  const LocalTextSuccessState({super.text});
}

final class LocalTextErrorState extends LocalTextState {
  const LocalTextErrorState({super.message});
}
