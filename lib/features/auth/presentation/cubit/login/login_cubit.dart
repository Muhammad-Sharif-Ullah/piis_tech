import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piis_tech/features/auth/domain/entities/login_entities.dart';
import 'package:piis_tech/features/auth/domain/entities/user_entities.dart';
import 'package:piis_tech/features/auth/domain/repositories/login_repo.dart';
import 'package:piis_tech/features/auth/presentation/cubit/authorization/bloc/authorization_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginEvent(LoginEntities payload, BuildContext context) async {
    emit(LoginLoading());
    LoginRepo.instance.logIn(payload).then((response) => response.fold(
            (errorMessage) => emit(LoginFailure(errorMessage: errorMessage)),
            (userData) {
          emit(LoginSuccessful(userData: userData));
          context
              .read<AuthorizationBloc>()
              .add(MakeAuthenticate(userInfo: userData));
        }));
  }
}
