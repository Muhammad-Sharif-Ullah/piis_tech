// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'dashboard_cubit.dart';

class DashboardState extends Equatable {
  int currentIndex;
  DashboardState({
    required this.currentIndex,
  });

  @override
  List<Object> get props => [currentIndex];
}
