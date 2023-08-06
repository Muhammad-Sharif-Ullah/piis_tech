part of 'authorization_bloc.dart';

abstract class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();

  @override
  List<Object> get props => [];
}

class MakeAuthenticate extends AuthorizationEvent {
  final UserEntities userInfo;
  const MakeAuthenticate({
    required this.userInfo,
  });
  @override
  List<Object> get props => [userInfo];
}

class MakeUnAuthenticate extends AuthorizationEvent {
  const MakeUnAuthenticate({required this.context});
  final BuildContext context;

  @override
  List<Object> get props => [context];
}

class CheckTokenUnAuthenticate extends AuthorizationEvent {
  const CheckTokenUnAuthenticate({
    required this.context,
    required this.userToken,
  });
  final BuildContext context;
  final String userToken;

  @override
  List<Object> get props => [context, userToken];
}
