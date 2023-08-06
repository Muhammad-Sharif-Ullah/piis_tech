part of 'active_employee_list_cubit.dart';

abstract class ActiveEmployeeListState extends Equatable {
  const ActiveEmployeeListState();

  @override
  List<Object> get props => [];
}

class ActiveEmployeeListInitial extends ActiveEmployeeListState {}

class ActiveEmployeeListLoading extends ActiveEmployeeListState {}

class ActiveEmployeeListLoaded extends ActiveEmployeeListState {
  final List<EmployeesEntities> employeeList;

  const ActiveEmployeeListLoaded(this.employeeList);
  @override
  List<Object> get props => [employeeList];
}

class ActiveEmployeeListFailure extends ActiveEmployeeListState {
  final String errorMessage;

  const ActiveEmployeeListFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
