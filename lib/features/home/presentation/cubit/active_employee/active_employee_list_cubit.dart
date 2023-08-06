import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piis_tech/core/constants/providers.dart';
import 'package:piis_tech/features/home/domain/entities/employee_entities.dart';
import 'package:piis_tech/features/home/domain/repositories/active_employee_list_repository.dart';

part 'active_employee_list_state.dart';

class ActiveEmployeeListCubit extends Cubit<ActiveEmployeeListState> {
  ActiveEmployeeListCubit() : super(ActiveEmployeeListInitial());
  activeEmployeeListEvent(BuildContext context) async {
    final authorizationState =
        BlocProvider.of<AuthorizationBloc>(context).state;
    if (authorizationState is Authenticate) {
      var userToken = authorizationState.userInfo.token;
      emit(ActiveEmployeeListLoading());
      await ActiveEmployeeListRepository.instance
          .getEmployeeList(userToken)
          .then((response) => response.fold(
              (error) => emit(ActiveEmployeeListFailure(error)),
              (success) => emit(ActiveEmployeeListLoaded(success))));
    } else {
      emit(const ActiveEmployeeListFailure("Need Authorization"));
    }
  }
}
