import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piis_tech/config/config.dart';
import 'package:piis_tech/config/navigation/routes.dart';
import 'package:piis_tech/core/constants/get_locator.dart';
import 'package:piis_tech/core/constants/providers.dart';
import 'package:piis_tech/core/constants/resources.dart';
import 'package:piis_tech/core/utility/app_extension.dart';
import 'package:piis_tech/core/utility/get_device_id.dart';
import 'package:piis_tech/core/utility/validator.dart';
import 'package:piis_tech/features/auth/domain/entities/login_entities.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPasswordNotVisible = true;

  @override
  void dispose() {
    userName.dispose();
    password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  0.1.sh.verticalSpace,
                  Align(
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: AppConfiguration.logoHeroTag,
                      child: SizedBox(
                        width: 0.5.sw,
                        height: 100,
                        child: Image.asset(R.ASSETS_IMAGES_PIIS_TECH_LOGO_PNG),
                      ),
                    ),
                  ),
                  0.1.sh.verticalSpace,
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Color(0xFF090D1D),
                      fontSize: 30,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w800,
                      height: 1.27,
                      letterSpacing: -1.20,
                    ),
                  ),
                  54.verticalSpace,
                  Text(
                    'User Name',
                    style: TextStyle(
                      color:
                          isDarkMode ? Colors.grey.shade300 : Color(0xFF090D1D),
                      fontSize: 14,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.14,
                    ),
                  ),
                  5.verticalSpace,
                  TextFormField(
                    controller: userName,
                    validator: (value) => value?.isValid(4, "User Name"),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        CupertinoIcons.mail_solid,
                        color: isDarkMode ? Colors.grey.shade300 : Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    'Password',
                    style: TextStyle(
                      color:
                          isDarkMode ? Colors.grey.shade300 : Color(0xFF090D1D),
                      fontSize: 14,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.14,
                    ),
                  ),
                  5.verticalSpace,
                  TextFormField(
                    controller: password,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    obscureText: isPasswordNotVisible,
                    validator: (value) => value?.trim().isValid(4, "Password"),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        CupertinoIcons.lock_fill,
                        color: isDarkMode ? Colors.grey.shade300 : Colors.black,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(isPasswordNotVisible
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash),
                        onPressed: () {
                          isPasswordNotVisible = !isPasswordNotVisible;
                          setState(() {});
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  SizedBox(
                    width: 1.sw,
                    child: BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccessful) {
                          getIt<GlobalKey<NavigatorState>>()
                              .currentState
                              ?.pushReplacementNamed(RouteName.Dashboard);
                        } else if (state is LoginFailure) {
                          context.snack(
                              title: state.errorMessage,
                              snackBarActionType: SnackBarActionType.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return SizedBox(
                              width: 50,
                              height: 50,
                              child: FittedBox(
                                  child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              )));
                        }
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                          ),
                          onPressed: () async => await onPressedSignIn(context),
                          child: const Text("Sign In"),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onPressedSignIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await getDeviceId().then((deviceToken) {
        if (deviceToken != null) {
          context.read<LoginCubit>().loginEvent(
              LoginEntities(
                  userName: userName.text.trim(),
                  password: password.text.trim(),
                  deviceToken: deviceToken,
                  utc: DateTime.now().toUtc().toIso8601String()),
              context);
        } else {
          context.snack(
              title:
                  "Could not get device information. Please re-lunch the app",
              snackBarActionType: SnackBarActionType.error);
        }
      });
    }
  }
}
