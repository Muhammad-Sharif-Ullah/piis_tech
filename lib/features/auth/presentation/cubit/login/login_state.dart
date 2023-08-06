part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccessful extends LoginState {
  final UserEntities userData;

  const LoginSuccessful({required this.userData});

  @override
  List<Object> get props => [userData];
}

class LoginFailure extends LoginState {
  final String errorMessage;

  const LoginFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
