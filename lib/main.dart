import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:piis_tech/config/config.dart';
import 'package:piis_tech/config/navigation/navigation.dart';
import 'package:piis_tech/config/theme/theme_store/theme_store_cubit.dart';
import 'package:piis_tech/core/constants/bloc_providers.dart';
import 'package:piis_tech/core/constants/get_locator.dart';
import 'package:piis_tech/core/observer/observer.dart';

Future<void> main() async {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  Bloc.observer = AppGlobalBlocObserver();

  runApp(const MyApp());
}

final navigatorKey = getIt<GlobalKey<NavigatorState>>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: BlocProviders.providers(),
            child: BlocBuilder<ThemeStoreCubit, ThemeState>(
              builder: (context, state) {
                return MaterialApp(
                  navigatorKey: navigatorKey,
                  title: AppConfiguration.appName,
                  theme: state.themeData,
                  darkTheme: state.themeData,
                  // theme: ThemeData.light().copyWith(
                  //   primaryColor: const Color(0xFFDC2129),
                  //   appBarTheme:
                  //       const AppBarTheme(backgroundColor: Colors.white),
                  //   useMaterial3: true,
                  // ),
                  themeMode: state.appTheme == AppThemeMode.light
                      ? ThemeMode.light
                      : ThemeMode.dark,
                  onGenerateRoute: RouteGenerator().onGenerateRoute,
                  navigatorObservers: [AppNavObserver()],
                );
              },
            ),
          );
        });
  }
}
