import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:piis_tech/config/config.dart';
import 'package:piis_tech/config/navigation/routes.dart';
import 'package:piis_tech/core/constants/get_locator.dart';
import 'package:piis_tech/core/constants/resources.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    startProgress();
  }

  void startProgress() {
    const progressDuration = Duration(milliseconds: 4700);
    const stepDuration = Duration(milliseconds: 40);

    int totalSteps =
        progressDuration.inMilliseconds ~/ stepDuration.inMilliseconds;
    int currentStep = 0;

    Timer.periodic(stepDuration, (timer) {
      currentStep++;
      setState(() {
        _progressValue = currentStep / totalSteps;
      });

      if (currentStep >= totalSteps) {
        timer.cancel();
        getIt<GlobalKey<NavigatorState>>()
            .currentState
            ?.pushReplacementNamed(RouteName.Dashboard);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Hero(
                tag: AppConfiguration.logoHeroTag,
                child: SizedBox(
                  width: 0.5.sw,
                  height: 100,
                  child:
                      Image.asset(R.ASSETS_IMAGES_PIIS_TECH_LOGO_PNG).animate()
                        ..scale(duration: 2000.ms).then().shimmer(),
                ),
              ),
              const Spacer(),
              Text(
                "Copyright © 2016-${DateTime.now().year}",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              10.verticalSpace,
              SafeArea(
                child: SizedBox(
                  width: 0.3.sw,
                  height: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _progressValue,
                      color: Theme.of(context).primaryColor,
                      minHeight: 5,
                    ),
                  ),
                ),
              ),
              10.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
