import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register your GlobalKey<NavigatorState> instance
  getIt.registerLazySingleton(() => GlobalKey<NavigatorState>());
  // getIt.registerSingleton<AuthorizationBloc>(AuthorizationBloc());
  getIt.registerLazySingleton(() => BuildContext);
}

void navigateTo(String routeName, {bool replace = false}) {
  final navigatorKey = getIt<GlobalKey<NavigatorState>>();

  if (replace) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  } else {
    navigatorKey.currentState?.pushNamed(routeName);
  }
}
