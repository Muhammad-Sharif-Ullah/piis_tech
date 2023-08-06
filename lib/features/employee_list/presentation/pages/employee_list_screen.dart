import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piis_tech/config/navigation/routes.dart';
import 'package:piis_tech/core/constants/get_locator.dart';
import 'package:piis_tech/core/constants/resources.dart';
import 'package:piis_tech/core/widgets/list_loader.dart';
import 'package:piis_tech/core/widgets/on_network_image.dart';
import 'package:piis_tech/features/employee_list/presentation/cubit/employee_list/employee_list_cubit.dart';
import 'package:piis_tech/features/home/domain/entities/employee_entities.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? CupertinoColors.black : null,
        elevation: 10,
        title: SizedBox(
          width: 0.25.sw,
          height: 100,
          child: Image.asset(
            R.ASSETS_IMAGES_PIIS_TECH_LOGO_PNG,
            color: isDarkMode ? Colors.white : null,
          ),
        ),
        centerTitle: true,
      ),
      body: const EmployeeListView(),
    );
  }
}

class EmployeeListView extends StatelessWidget {
  const EmployeeListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<EmployeeListCubit, EmployeeListState>(
      builder: (context, state) {
        if (state is EmployeeListLoaded) {
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
                        .read<EmployeeListCubit>()
                        .employeeListEvent(context);
                  },
                  child: const Text("Refresh"),
                )
              ],
            ));
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<EmployeeListCubit>().employeeListEvent(context);
            },
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              itemBuilder: (context, index) {
                EmployeesEntities employee = state.employeeList[index];
                return Card(
                  color: isDarkMode ? CupertinoColors.black : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    dense: true,
                    leading: Hero(
                      tag: "Profile-Hero",
                      child: ClipOval(
                        child: OnNetWorkImage(
                          url: employee.profilePicture,
                          height: 45,
                          width: 45,
                        ),
                      ),
                    ),
                    title: Text(employee.fullName),
                    subtitle: Text(employee.designation),
                    onTap: () {
                      getIt<GlobalKey<NavigatorState>>()
                          .currentState
                          ?.pushNamed(RouteName.EmployeeProfile,
                              arguments: employee);
                    },
                    trailing: Icon(
                      CupertinoIcons.right_chevron,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => 10.verticalSpace,
              itemCount: state.employeeList.length,
            ),
          );
        } else if (state is EmployeeListFailure) {
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
                  context.read<EmployeeListCubit>().employeeListEvent(context);
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
