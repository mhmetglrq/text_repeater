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

  const RepeatTextEvent({required this.text, required this.times, required this.newLine});

  @override
  List<Object?> get props => [text, times, newLine];
}