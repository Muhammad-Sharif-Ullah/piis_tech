part of 'employee_list_cubit.dart';

abstract class EmployeeListState extends Equatable {
  const EmployeeListState();

  @override
  List<Object> get props => [];
}

class EmployeeListInitial extends EmployeeListState {}

class EmployeeListLoading extends EmployeeListState {}

class EmployeeListLoaded extends EmployeeListState {
  final List<EmployeesEntities> employeeList;

  const EmployeeListLoaded(this.employeeList);
  @override
  List<Object> get props => [employeeList];
}

class EmployeeListFailure extends EmployeeListState {
  final String errorMessage;

  const EmployeeListFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
