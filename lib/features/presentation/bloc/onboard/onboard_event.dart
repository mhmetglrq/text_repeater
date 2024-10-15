

part of 'onboard_bloc.dart';

sealed class OnboardEvent extends Equatable {
  const OnboardEvent();

  @override
  List<Object?> get props => [];
}

class GetOnboardStatusEvent extends OnboardEvent {
  const GetOnboardStatusEvent();
}

class SaveOnboardStatusEvent extends OnboardEvent {
  final bool status;

  const SaveOnboardStatusEvent(this.status);

  @override
  List<Object?> get props => [status];
}
