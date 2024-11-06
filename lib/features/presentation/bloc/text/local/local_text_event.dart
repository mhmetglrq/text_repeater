part of 'local_text_bloc.dart';

sealed class LocalTextEvent extends Equatable {
  final String? text;
  final bool? isRecent;
  const LocalTextEvent({this.text, this.isRecent});

  @override
  List<Object?> get props => [text, isRecent];
}

class RepeatTextEvent extends LocalTextEvent {
  final int times;
  final bool newLine;

  const RepeatTextEvent(
      {required super.text,
      required this.times,
      required this.newLine,
      super.isRecent});

  @override
  List<Object?> get props => [times, newLine];
}

class ReverseTextEvent extends LocalTextEvent {
  const ReverseTextEvent({required super.text, super.isRecent});
}

class SortTextEvent extends LocalTextEvent {
  const SortTextEvent({required super.text, super.isRecent});
}

class RandomizeTextEvent extends LocalTextEvent {
  const RandomizeTextEvent({required super.text, super.isRecent});
}

class WordCloudEvent extends LocalTextEvent {
  const WordCloudEvent({required super.text, super.isRecent});
}

class SaveTextEvent extends LocalTextEvent {
  final DateTime createdAt;
  final String type;
  final int repeatCount;

  const SaveTextEvent(
      {required super.text,
      required this.createdAt,
      required this.type,
      required this.repeatCount,
      super.isRecent});

  @override
  List<Object?> get props => [text, createdAt, type, repeatCount];
}

class GetSavedTextsEvent extends LocalTextEvent {
  const GetSavedTextsEvent();
}

class DeleteTextEvent extends LocalTextEvent {
  const DeleteTextEvent({required super.text});
}

class RemoveTextEvent extends LocalTextEvent {
  const RemoveTextEvent();
}

class IncrementAdCountEvent extends LocalTextEvent {
  final int? adCount;
  const IncrementAdCountEvent({this.adCount});
}
