import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piis_tech/features/auth/presentation/cubit/authorization/bloc/authorization_bloc.dart';
import 'package:piis_tech/features/home/domain/entities/attendance_entities.dart';
import 'package:piis_tech/features/home/domain/repositories/employee_attendance_list_repository.dart';

part 'employee_attendance_state.dart';

class EmployeeAttendanceCubit extends Cubit<EmployeeAttendanceState> {
  EmployeeAttendanceCubit() : super(EmployeeAttendanceListInitial());
  employeeAttendanceListEvent(BuildContext context) async {
    final authorizationState =
        BlocProvider.of<AuthorizationBloc>(context).state;
    if (authorizationState is Authenticate) {
      var userToken = authorizationState.userInfo.token;
      var employeeId = authorizationState.userInfo.user.userGuidId;
      emit(EmployeeAttendanceListLoading());
      await EmployeeAttendanceListRepository.instance
          .getEmployeeList(
            userToken,
            employeeId,
          )
          .then((response) => response.fold(
              (error) => emit(EmployeeAttendanceListFailure(error)),
              (success) => emit(EmployeeAttendanceListLoaded(success))));
    } else {
      emit(const EmployeeAttendanceListFailure("Need Authorization"));
    }
  }
}
