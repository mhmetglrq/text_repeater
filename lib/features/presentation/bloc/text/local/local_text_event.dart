part of 'local_text_bloc.dart';

sealed class LocalTextEvent extends Equatable {
  const LocalTextEvent();

  @override
  List<Object?> get props => [];
}

class RepeatTextEvent extends LocalTextEvent {
  final String text;
  final int times;
  final bool newLine;

  const RepeatTextEvent(
      {required this.text, required this.times, required this.newLine});

  @override
  List<Object?> get props => [text, times, newLine];
}

class ReverseTextEvent extends LocalTextEvent {
  final String text;

  const ReverseTextEvent({required this.text});

  @override
  List<Object?> get props => [text];
}

class SortTextEvent extends LocalTextEvent {
  final String text;

  const SortTextEvent({required this.text});

  @override
  List<Object?> get props => [text];
}

class RandomizeTextEvent extends LocalTextEvent {
  final String text;

  const RandomizeTextEvent({required this.text});

  @override
  List<Object?> get props => [text];
}

class WordCloudEvent extends LocalTextEvent {
  final String text;

  const WordCloudEvent({required this.text});

  @override
  List<Object?> get props => [text];
}

class SaveTextEvent extends LocalTextEvent {
  final String text;
  final DateTime createdAt;
  final String type;
  final int repeatCount;

  const SaveTextEvent(
      {required this.text,
      required this.createdAt,
      required this.type,
      required this.repeatCount});

  @override
  List<Object?> get props => [text, createdAt, type, repeatCount];
}

class GetSavedTextsEvent extends LocalTextEvent {
  const GetSavedTextsEvent();
}

class DeleteTextEvent extends LocalTextEvent {
  final String text;

  const DeleteTextEvent({required this.text});

  @override
  List<Object?> get props => [text];
}

class RemoveTextEvent extends LocalTextEvent {
  const RemoveTextEvent();
}
