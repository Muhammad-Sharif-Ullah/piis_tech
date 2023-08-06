import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:piis_tech/core/api/api_endpoint.dart';
import 'package:piis_tech/core/api/api_provider.dart';
import 'package:piis_tech/core/constants/providers.dart';
import 'package:piis_tech/core/theme/app_colors.dart';
import 'package:piis_tech/core/utility/app_dialog_loader.dart';
import 'package:piis_tech/core/utility/app_extension.dart';
import 'package:piis_tech/core/utility/image_upload.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ProfileBody(),
    );
  }
}

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late Map<String, dynamic> imageDataMap = {};
  String imageFile = '';
  static final dayFormat = DateFormat('d MMMM EEEE y');
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: BlocBuilder<AuthorizationBloc, AuthorizationState>(
        builder: (context, state) {
          if (state is Authenticate) {
            final userData = state.userInfo;
            // log(userData.user.toJson().toString());
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(
                          CupertinoIcons.person_alt,
                          size: 100,
                        ),
                        // backgroundImage: AssetImage(
                        //     'assets/avatar.jpg'), // Replace with your image asset
                      ),
                      Positioned(
                        right: 0,
                        top: -10,
                        child: IconButton.filled(
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.black),
                          highlightColor: Colors.black,
                          color: Colors.white,
                          onPressed: () async =>
                              await profileUpdate(userData.token, isDarkMode),
                          icon: const Icon(Icons.edit),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userData.user.fullName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userData.user.designation,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  30.verticalSpace,
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Basic Information',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 1.sw,
                    decoration: ShapeDecoration(
                      color: isDarkMode ? CupertinoColors.black : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
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
                      children: [
                        ListTile(
                          dense: true,
                          leading: const Icon(CupertinoIcons.building_2_fill),
                          title: Text(
                            "Company Name",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          subtitle: Text(
                            userData.user.companyName,
                            style: const TextStyle(
                              // color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                              letterSpacing: 0.25,
                            ),
                          ),
                          onTap: () {
                            launchUrl(Uri.parse('https://www.piistech.com/'));
                          },
                          trailing: const Icon(CupertinoIcons.right_chevron),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        ListTile(
                          dense: true,
                          leading: const Icon(CupertinoIcons.mail),
                          title: Text(
                            "Email",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          subtitle: Text(
                            userData.user.email,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                              letterSpacing: 0.25,
                            ),
                          ),
                          onTap: () {
                            launchUrl(
                                Uri.parse('mailto:${userData.user.email}'));
                          },
                          trailing: const Icon(CupertinoIcons.right_chevron),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        ListTile(
                          dense: true,
                          leading: const Icon(CupertinoIcons.phone),
                          title: Text(
                            "Phone",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          subtitle: Text(
                            userData.user.phone,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                              letterSpacing: 0.25,
                            ),
                          ),
                          onTap: () {
                            launchUrl(Uri.parse('tel:${userData.user.phone}'));
                          },
                          trailing: const Icon(CupertinoIcons.right_chevron),
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Theme.of(context).primaryColor,
                        ),
                        ListTile(
                          dense: true,
                          leading: const Icon(Icons.date_range),
                          title: Text(
                            "Join Data",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          subtitle: Text(
                            dayFormat
                                .format(DateTime.parse(userData.user.joinDate)),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                              letterSpacing: 0.25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  30.verticalSpace,
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Settings',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  10.verticalSpace,
                  Container(
                    width: 1.sw,
                    decoration: ShapeDecoration(
                      color: isDarkMode ? CupertinoColors.black : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
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
                      children: [
                        BlocBuilder<ThemeStoreCubit, ThemeState>(
                          builder: (context, state) {
                            return ListTile(
                              dense: true,
                              leading: state.appTheme == AppThemeMode.light
                                  ? const Icon(CupertinoIcons.moon_fill)
                                  : const Icon(CupertinoIcons.moon_circle_fill),
                              title: Text("Theme",
                                  style: Theme.of(context).textTheme.bodySmall),
                              subtitle: Text(
                                state.appTheme == AppThemeMode.light
                                    ? "Light Theme"
                                    : "Dark Theme",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.43,
                                  letterSpacing: 0.25,
                                ),
                              ),
                              onTap: () {
                                context.read<ThemeStoreCubit>().toggleTheme();
                              },
                              trailing: const Icon(
                                CupertinoIcons.right_chevron,
                                color: Colors.black,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        context
                            .read<AuthorizationBloc>()
                            .add(MakeUnAuthenticate(context: context));
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Logout"),
                    ),
                  )
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Future<void> profileUpdate(String token, isDarkMode) async {
    await imageModal(
      context,
      "Upload Profile Picture",
      'Choose Options',
      '3 MB',
      isDarkMode,
      imageDataMap,
    ).then((image) async {
      if (image != null) {
        if (int.parse(image["indexFile"].toString()) < 3) {
          if (image['sizeName'] == "mb" &&
              int.parse(image['fileSize'].toString()) <= 2) {
            imageFile = image['rename'];
          } else if (image['sizeName'] == "kb") {
            imageFile = image['rename'];

            FormData formData = FormData.fromMap({
              'file': await MultipartFile.fromFile(imageFile,
                  filename: "profile_image"),
            });
            setState(() {});
            if (mounted) {
              loader(context);
            }

            AppApiProvider.instance
                .post(
                  APIRequestParam(
                      path: ApiEndPoints.mgmtModule.uploadImage,
                      data: formData,
                      options: Options(headers: {
                        "Authorization": "Bearer $token",
                      })),
                )
                .then((response) => response.fold((error) {
                      Navigator.pop(context);
                      log(error.message.toString());
                      context.snack(
                          duration: const Duration(seconds: 2),
                          title: error.message.toString(),
                          snackBarActionType: SnackBarActionType.warning);
                    }, (success) {
                      Navigator.pop(context);
                      log(success.data.toString());
                      context.snack(
                          duration: const Duration(seconds: 2),
                          title: success.data.toString(),
                          snackBarActionType: SnackBarActionType.warning);
                    }));
          } else {
            context.snack(
                duration: const Duration(seconds: 2),
                title:
                    "File Too Large (${image["fileSize"] + image["sizeName"]})",
                snackBarActionType: SnackBarActionType.warning);
            imageFile = '';
            setState(() {});
          }
        } else {
          context.snack(
              duration: const Duration(seconds: 2),
              title:
                  "File Too Large (${image["fileSize"] + image["sizeName"]})",
              snackBarActionType: SnackBarActionType.warning);
          imageFile = '';
          setState(() {});
        }
      }
    });
  }
}

void launchURL(Uri url) async {
  // You can use the url_launcher package to open the URL
  await launchUrl(url);
}
