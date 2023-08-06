part of 'employee_attendance_cubit.dart';

abstract class EmployeeAttendanceState extends Equatable {
  const EmployeeAttendanceState();

  @override
  List<Object> get props => [];
}

class EmployeeAttendanceListInitial extends EmployeeAttendanceState {}

class EmployeeAttendanceListLoading extends EmployeeAttendanceState {}

class EmployeeAttendanceListLoaded extends EmployeeAttendanceState {
  final List<AttendanceEntities> employeeList;

  const EmployeeAttendanceListLoaded(this.employeeList);
  @override
  List<Object> get props => [employeeList];
}

class EmployeeAttendanceListFailure extends EmployeeAttendanceState {
  final String errorMessage;

  const EmployeeAttendanceListFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
