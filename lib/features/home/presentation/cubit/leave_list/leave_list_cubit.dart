import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piis_tech/features/auth/presentation/cubit/authorization/bloc/authorization_bloc.dart';
import 'package:piis_tech/features/home/domain/repositories/leave_list_repository.dart';

part 'leave_list_state.dart';

class LeaveListCubit extends Cubit<LeaveListState> {
  LeaveListCubit() : super(LeaveListInitial());

  leaveListEvent(BuildContext context) async {
    final authorizationState =
        BlocProvider.of<AuthorizationBloc>(context).state;
    if (authorizationState is Authenticate) {
      var userToken = authorizationState.userInfo.token;
      var userId = authorizationState.userInfo.user.userGuidId;
      emit(LeaveListLoading());
      await LeaveListRepository.instance
          .getEmployeeList(userToken, userId)
          .then((response) => response.fold(
              (error) => emit(LeaveListFailure(error)),
              (success) => emit(LeaveListLoaded(success))));
    } else {
      emit(const LeaveListFailure("Need Authorization"));
    }
  }
}
