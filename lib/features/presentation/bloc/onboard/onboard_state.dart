part of 'onboard_bloc.dart';

sealed class OnboardState extends Equatable {
  final bool? status;

  const OnboardState({this.status});

  @override
  List<Object?> get props => [status];
}

class OnboardInitialState extends OnboardState {
  const OnboardInitialState();
}

class OnboardLoadingState extends OnboardState {
  const OnboardLoadingState();
}

class OnboardSuccessState extends OnboardState {
  const OnboardSuccessState({super.status});

  @override
  List<Object?> get props => [status];
}

class OnboardErrorState extends OnboardState {
  final String message;

  const OnboardErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
