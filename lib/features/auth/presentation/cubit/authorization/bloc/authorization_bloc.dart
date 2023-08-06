import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:piis_tech/features/auth/domain/entities/user_entities.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState>
    with HydratedMixin {
  AuthorizationBloc() : super(UnAuthenticate()) {
    on<MakeAuthenticate>((event, emit) {
      emit(Authenticate(userInfo: event.userInfo));
    });
    on<MakeUnAuthenticate>((event, emit) async {
      await clear().then((value) {
        emit(UnAuthenticate());
      });

      // await clear().whenComplete(
      //     () => AutoRouter.of(event.context).push(const LoginRoute()));
    });

    on<CheckTokenUnAuthenticate>((event, emit) async {
      //  emit(Authenticate(userInfo: event.userInfo));
    });
  }

  @override
  AuthorizationState? fromJson(Map<String, dynamic> json) {
    if (json['userData'] != null) {
      final UserEntities userInfo = UserEntities.fromJson(json['userData']);
      return Authenticate(userInfo: userInfo);
    } else {
      return UnAuthenticate();
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthorizationState state) {
    if (state is Authenticate) {
      log(state.userInfo.toJson());
      return <String, dynamic>{"userData": state.userInfo.toJson().toString()};
    } else {
      return null;
    }
  }
}
