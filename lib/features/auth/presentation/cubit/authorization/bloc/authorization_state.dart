part of 'authorization_bloc.dart';

abstract class AuthorizationState extends Equatable {
  const AuthorizationState();

  @override
  List<Object> get props => [];
}

class UnAuthenticate extends AuthorizationState {}

class Authenticate extends AuthorizationState {
  final UserEntities userInfo;
  const Authenticate({
    required this.userInfo,
  });
  @override
  List<Object> get props => [userInfo];
}
