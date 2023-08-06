import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:piis_tech/core/widgets/on_network_image.dart';
import 'package:piis_tech/features/home/domain/entities/employee_entities.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployeeProfileScreen extends StatelessWidget {
  final EmployeesEntities userData;
  const EmployeeProfileScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);
  static final dayFormat = DateFormat('d MMMM EEEE y');

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Hero(
                tag: "Profile-Hero",
                child: ClipOval(
                  child: OnNetWorkImage(
                    url: userData.profilePicture,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                userData.fullName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                userData.designation,
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
                      leading: Icon(
                          userData.sex == "Male" ? Icons.male : Icons.female),
                      title: Text("Gender",
                          style: Theme.of(context).textTheme.bodySmall),
                      subtitle: Text(
                        userData.sex,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                          letterSpacing: 0.25,
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                    ListTile(
                      dense: true,
                      leading: const Icon(CupertinoIcons.mail),
                      title: Text("Email",
                          style: Theme.of(context).textTheme.bodySmall),
                      subtitle: Text(
                        userData.email,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                          letterSpacing: 0.25,
                        ),
                      ),
                      onTap: () {
                        launchUrl(Uri.parse('mailto:${userData.email}'));
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
                      title: Text("Phone",
                          style: Theme.of(context).textTheme.bodySmall),
                      subtitle: Text(
                        userData.phoneNumber,
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                          letterSpacing: 0.25,
                        ),
                      ),
                      onTap: () {
                        launchUrl(Uri.parse('tel:${userData.phoneNumber}'));
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
                      leading: const Icon(
                        Icons.date_range,
                      ),
                      title: Text("Join Data",
                          style: Theme.of(context).textTheme.bodySmall),
                      subtitle: Text(
                        dayFormat.format(DateTime.parse(userData.joiningDate)),
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
            ],
          ),
        ),
      ),
    );
  }
}
