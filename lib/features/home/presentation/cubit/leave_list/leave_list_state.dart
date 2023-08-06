part of 'leave_list_cubit.dart';

abstract class LeaveListState extends Equatable {
  const LeaveListState();

  @override
  List<Object> get props => [];
}

class LeaveListInitial extends LeaveListState {}

class LeaveListLoading extends LeaveListState {}

class LeaveListLoaded extends LeaveListState {
  final dynamic leaveList;

  const LeaveListLoaded(this.leaveList);
  @override
  List<Object> get props => [leaveList];
}

class LeaveListFailure extends LeaveListState {
  final String errorMessage;

  const LeaveListFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
