import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<int> {
  int currentIndex = 0;
  DashboardCubit() : super(0);

  updateCurrentIndex(int index) {
    currentIndex = index;
    emit(index);
  }
}
