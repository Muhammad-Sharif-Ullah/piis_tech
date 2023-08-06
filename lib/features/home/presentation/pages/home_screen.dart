import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piis_tech/config/config.dart';
import 'package:piis_tech/config/navigation/routes.dart';
import 'package:piis_tech/core/api/api_endpoint.dart';
import 'package:piis_tech/core/api/api_provider.dart';
import 'package:piis_tech/core/constants/get_locator.dart';
import 'package:piis_tech/core/constants/resources.dart';
import 'package:piis_tech/core/utility/app_dialog_loader.dart';
import 'package:piis_tech/core/utility/app_extension.dart';
import 'package:piis_tech/core/widgets/list_loader.dart';
import 'package:piis_tech/core/widgets/on_network_image.dart';
import 'package:piis_tech/features/auth/presentation/cubit/authorization/bloc/authorization_bloc.dart';
import 'package:piis_tech/features/home/domain/entities/employee_entities.dart';
import 'package:piis_tech/features/home/presentation/cubit/active_employee/active_employee_list_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDateTime = DateTime.now();
  bool isLoading = false;

  Future<void> callApi() async {
    Navigator.pop(context);

    final authorizationState =
        BlocProvider.of<AuthorizationBloc>(context).state;
    if (authorizationState is Authenticate) {
      loader(context);
      var userToken = authorizationState.userInfo.token;
      var userId = authorizationState.userInfo.user.userGuidId;
      await AppApiProvider.instance
          .post(APIRequestParam(
              path: ApiEndPoints.mgmtModule.saveAttendance,
              queryParameters: {
                "clockType": selectedDateTime.toIso8601String(),
                "lat": "0",
                "lng": "0",
              },
              options: Options(headers: {
                "Authorization": "Bearer $userToken",
                "employeeId": userId,
              })))
          .then((response) => response.fold((error) {
                Navigator.pop(context);
                log(error.message.toString());
                context.snack(
                    title: error.message.toString(),
                    snackBarActionType: SnackBarActionType.warning,
                    duration: 5000.ms);
              }, (success) {
                Navigator.pop(context);
                log(success.data.toString());
                context.snack(
                    title: success.data['success'] == true
                        ? "Success"
                        : success.data['error'].toString(),
                    snackBarActionType: SnackBarActionType.success);
              }));
    } else {
      context.snack(
          title: "Need Authentication",
          snackBarActionType: SnackBarActionType.warning);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? CupertinoColors.black : null,
        elevation: 10,
        title: Hero(
          tag: AppConfiguration.logoHeroTag,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 0.25.sw,
              height: 50,
              child: Image.asset(
                R.ASSETS_IMAGES_PIIS_TECH_LOGO_PNG,
                color: isDarkMode ? Colors.white : null,
              ),
            ),
          ),
        ),
        // centerTitle: true,
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 150,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return GridTapCard(
                heroTag: "My-Attendance-List",
                image:
                    "https://cdn-icons-png.flaticon.com/512/2620/2620267.png",
                text: "My Attendance List",
                isDarkMode: isDarkMode,
                onTap: () {
                  getIt<GlobalKey<NavigatorState>>()
                      .currentState
                      ?.pushNamed(RouteName.AttendanceList);
                },
              );
            case 1:
              return GridTapCard(
                heroTag: "Manual-Entry",
                image:
                    "https://previews.123rf.com/images/vecstock/vecstock2005/vecstock200516110/147390795-calendar-planner-icon-over-white-background-half-line-half-color-style-vector-illustration.jpg",
                text: "Manual Entry",
                isDarkMode: isDarkMode,
                onTap: () {
                  DateTime now = DateTime.now();
                  DateTime minDate = now.add(const Duration(days: 1));
                  DateTime maxDate = now.add(const Duration(days: 5));
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) =>
                        StatefulBuilder(builder: (context, setState) {
                      return Container(
                        height: 350,
                        decoration: BoxDecoration(
                            color: isDarkMode
                                ? CupertinoColors.black
                                : CupertinoColors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Column(
                          children: [
                            20.verticalSpace,
                            Material(
                              color: Colors.transparent,
                              child: Text(
                                "Select Data And Time",
                                style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 20),
                              ),
                            ),
                            10.verticalSpace,
                            SizedBox(
                              height: 200,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.dateAndTime,
                                minimumDate: minDate,
                                maximumDate: maxDate,
                                initialDateTime: minDate,
                                onDateTimeChanged: (DateTime newDateTime) {
                                  setState(() {
                                    selectedDateTime = newDateTime;
                                  });
                                },
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () async {
                                await callApi();
                              },
                              child: const Text('Done'),
                            ),
                          ],
                        ),
                      );
                    }),
                  ).then((dateTIme) => {});
                },
              );
            case 2:
              return GridTapCard(
                heroTag: "My-Leave-List",
                image:
                    "https://toppng.com/uploads/preview/form-icon-leave-form-11563399902l3xwyckxi9.png",
                text: "My Leave List",
                isDarkMode: isDarkMode,
                onTap: () {
                  getIt<GlobalKey<NavigatorState>>()
                      .currentState
                      ?.pushNamed(RouteName.LeaveList);
                },
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class GridTapCard extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String text;
  final String heroTag;
  const GridTapCard({
    Key? key,
    required this.onTap,
    required this.image,
    required this.text,
    required this.heroTag,
    required this.isDarkMode,
  }) : super(key: key);

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: double.maxFinite,
        decoration: ShapeDecoration(
          color: isDarkMode ? Colors.black : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 1),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: heroTag,
              child: OnNetWorkImage(
                url: image,
                height: 50,
                width: 50,
              ),
            ),
            20.verticalSpace,
            Text(text),
          ],
        ),
      ),
    );
  }
}

class ActiveEmployeeListView extends StatelessWidget {
  const ActiveEmployeeListView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<ActiveEmployeeListCubit, ActiveEmployeeListState>(
      builder: (context, state) {
        if (state is ActiveEmployeeListLoaded) {
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
                    "Active Employee List is Empty",
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
                  child: const Text("Refresh"),
                )
              ],
            ));
          }
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<ActiveEmployeeListCubit>()
                  .activeEmployeeListEvent(context);
            },
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              itemBuilder: (context, index) {
                EmployeesEntities employee = state.employeeList[index];
                return Card(
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
        } else if (state is ActiveEmployeeListFailure) {
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
