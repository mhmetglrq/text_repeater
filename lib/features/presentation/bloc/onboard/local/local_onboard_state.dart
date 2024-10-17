part of 'local_onboard_bloc.dart';

sealed class LocalOnboardState extends Equatable {
  final bool? status;

  const LocalOnboardState({this.status});

  @override
  List<Object?> get props => [status];
}

class OnboardInitialState extends LocalOnboardState {
  const OnboardInitialState();
}

class OnboardLoadingState extends LocalOnboardState {
  const OnboardLoadingState();
}

class OnboardSuccessState extends LocalOnboardState {
  const OnboardSuccessState({super.status});

  @override
  List<Object?> get props => [status];
}

class OnboardErrorState extends LocalOnboardState {
  final String message;

  const OnboardErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
