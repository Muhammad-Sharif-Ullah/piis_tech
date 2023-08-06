import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:piis_tech/core/widgets/list_loader.dart';
import 'package:piis_tech/features/home/domain/entities/attendance_entities.dart';
import 'package:piis_tech/features/home/presentation/cubit/active_employee/active_employee_list_cubit.dart';
import 'package:piis_tech/features/home/presentation/cubit/employee_attendance/employee_attendance_cubit.dart';

class AttendanceListScreen extends StatelessWidget {
  const AttendanceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? CupertinoColors.black : null,
        title: const Hero(
          tag: "My-Attendance-List",
          child: Text('Attendance List'),
        ),
      ),
      body: const EmployeeAttendanceListView(),
    );
  }
}

class EmployeeAttendanceListView extends StatelessWidget {
  const EmployeeAttendanceListView({super.key});

  static final timeFormat = DateFormat('h:m:s a');
  static final dayFormat = DateFormat('d MMMM EEEE y');

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<EmployeeAttendanceCubit, EmployeeAttendanceState>(
      builder: (context, state) {
        if (state is EmployeeAttendanceListLoaded) {
          if (state.employeeList.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.person_3_fill,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: 50,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    "Attendance List is Empty",
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    context
                        .read<EmployeeAttendanceCubit>()
                        .employeeAttendanceListEvent(context);
                  },
                  child: const Text("Refresh"),
                )
              ],
            ));
          }
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<EmployeeAttendanceCubit>()
                  .employeeAttendanceListEvent(context);
            },
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              itemBuilder: (context, index) {
                AttendanceEntities attendance = state.employeeList[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    dense: true,
                    leading: attendance.clockType == "ClockIn"
                        ? const CircleAvatar(
                            radius: 8, backgroundColor: Colors.greenAccent)
                        : const CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.redAccent,
                          ),
                    subtitle: Text(
                        "${timeFormat.format(DateTime.parse(attendance.clockInTime).toUtc())}\t--\t${dayFormat.format(DateTime.parse(attendance.clockInTime).toUtc())}"),
                    title: Text(attendance.clockType),
                    onTap: () {},
                  ),
                );
              },
              separatorBuilder: (context, index) => 5.verticalSpace,
              itemCount: state.employeeList.length,
            ),
          );
        } else if (state is EmployeeAttendanceListFailure) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context
                      .read<ActiveEmployeeListCubit>()
                      .activeEmployeeListEvent(context);
                },
                child: const Text("Please Try Again"),
              )
            ],
          ));
        }
        return const ListLoader();
      },
    );
  }
}
