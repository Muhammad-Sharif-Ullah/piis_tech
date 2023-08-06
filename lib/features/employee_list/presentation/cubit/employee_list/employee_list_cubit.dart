import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piis_tech/core/constants/providers.dart';
import 'package:piis_tech/features/employee_list/data/repositories/employee_list_repository.dart';
import 'package:piis_tech/features/home/domain/entities/employee_entities.dart';

part 'employee_list_state.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {
  EmployeeListCubit() : super(EmployeeListInitial());

  employeeListEvent(BuildContext context) async {
    final authorizationState =
        BlocProvider.of<AuthorizationBloc>(context).state;
    if (authorizationState is Authenticate) {
      var userToken = authorizationState.userInfo.token;
      emit(EmployeeListLoading());
      await EmployeeListRepository.instance.getEmployeeList(userToken).then(
          (response) => response.fold(
              (error) => emit(EmployeeListFailure(error)),
              (success) => emit(EmployeeListLoaded(success))));
    } else {
      emit(const EmployeeListFailure("Need Authorization"));
    }
  }
}
