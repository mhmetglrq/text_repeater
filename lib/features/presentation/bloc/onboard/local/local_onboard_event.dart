part of 'local_onboard_bloc.dart';

sealed class LocalOnboardEvent extends Equatable {
  const LocalOnboardEvent();

  @override
  List<Object?> get props => [];
}

class GetOnboardStatusEvent extends LocalOnboardEvent {
  const GetOnboardStatusEvent();
}

class SaveOnboardStatusEvent extends LocalOnboardEvent {
  final bool status;

  const SaveOnboardStatusEvent(this.status);

  @override
  List<Object?> get props => [status];
}
