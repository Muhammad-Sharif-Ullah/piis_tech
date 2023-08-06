import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piis_tech/core/constants/providers.dart';

class BlocProviders {
  static BlocProviders? _instance;
  // Avoid self instance
  BlocProviders._();
  static BlocProviders get instance {
    _instance ??= BlocProviders._();
    return _instance!;
  }

  static List<BlocProvider> providers() {
    return [
      BlocProvider<SplashCubit>(create: (context) => SplashCubit()),
      BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
      BlocProvider<AuthorizationBloc>(create: (context) => AuthorizationBloc()),
      BlocProvider<DashboardCubit>(create: (context) => DashboardCubit()),
      BlocProvider<ThemeStoreCubit>(create: (context) => ThemeStoreCubit()),
      BlocProvider<EmployeeListCubit>(create: (context) => EmployeeListCubit()),
      BlocProvider<ActiveEmployeeListCubit>(
          create: (context) => ActiveEmployeeListCubit()),
      BlocProvider<LeaveListCubit>(create: (context) => LeaveListCubit()),
      BlocProvider<EmployeeAttendanceCubit>(
          create: (context) => EmployeeAttendanceCubit()),
    ];
  }
}
