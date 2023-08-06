import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piis_tech/core/constants/providers.dart';
import 'package:piis_tech/core/theme/app_colors.dart';
import 'package:piis_tech/core/utility/wanna_exit_from_app.dart';
import 'package:piis_tech/features/employee_list/presentation/pages/employee_list_screen.dart';
import 'package:piis_tech/features/home/presentation/pages/home_screen.dart';
import 'package:piis_tech/features/profile/presentation/pages/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> screens = [
    const HomeScreen(),
    const EmployeeListScreen(),
    const ProfileScreen()
  ];
  @override
  void initState() {
    super.initState();
    context.read<EmployeeListCubit>().employeeListEvent(context);
    context.read<ActiveEmployeeListCubit>().activeEmployeeListEvent(context);
    context
        .read<EmployeeAttendanceCubit>()
        .employeeAttendanceListEvent(context);
    context.read<LeaveListCubit>().leaveListEvent(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /// A Before App Exit Message
        ///[Don't use this logic for IOS] otherwise IOS will Reject The APP
        if (Platform.isAndroid) {
          // SystemNavigator.pop();
          return wannaExitFromApp(context);
          //  Navigator.of(context).pop(false);
        }
        return false;
      },
      child: Scaffold(
        body: BlocBuilder<DashboardCubit, int>(
          builder: (context, state) {
            return IndexedStack(
              index: state,
              children: screens,
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<DashboardCubit, int>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: state,
              type: BottomNavigationBarType.fixed,
              fixedColor: AppColors.primaryColor,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              onTap: (index) =>
                  context.read<DashboardCubit>().updateCurrentIndex(index),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person_3_fill),
                  label: 'Employee List',
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person_alt),
                  label: 'Profile',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
