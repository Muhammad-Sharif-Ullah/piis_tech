import 'package:flutter/material.dart';
import 'package:piis_tech/config/navigation/auth_gurd.dart';
import 'package:piis_tech/config/navigation/routes.dart';
import 'package:piis_tech/config/navigation/screens.dart';
import 'package:piis_tech/features/home/domain/entities/employee_entities.dart';
import 'package:piis_tech/features/home/presentation/pages/attendance_list_screen.dart';
import 'package:piis_tech/features/home/presentation/pages/leave_list_screen.dart';

class RouteGenerator {
  static final RouteGenerator _instance = RouteGenerator._internal();

  factory RouteGenerator() {
    return _instance;
  }

  RouteGenerator._internal();

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.SPLASH:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen(),
          settings: settings,
        );
      case RouteName.Auth:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginScreen(),
          settings: settings,
        );
      case RouteName.LeaveList:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LeaveListScreen(),
          settings: settings,
        );
      case RouteName.Dashboard:
        return MaterialPageRoute(
          builder: (_) => AuthGuard(
            authenticatedBuilder: (_) => const DashboardScreen(),
            unauthenticatedBuilder: (_) => const LoginScreen(),
          ),
          settings: settings,
        );
      case RouteName.Home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
          settings: settings,
        );
      case RouteName.AttendanceList:
        return MaterialPageRoute(
          builder: (BuildContext context) => const AttendanceListScreen(),
          settings: settings,
        );
      case RouteName.Profile:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ProfileScreen(),
          settings: settings,
        );
      case RouteName.EmployeeList:
        return MaterialPageRoute(
          builder: (BuildContext context) => const EmployeeListScreen(),
          settings: settings,
        );
      case RouteName.EmployeeProfile:
        final args = settings.arguments as EmployeesEntities?;
        if (args != null) {
          return MaterialPageRoute(
            builder: (BuildContext context) => EmployeeProfileScreen(
              userData: args,
            ),
            settings: settings,
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }
}

// Method to handle error case
Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (BuildContext context) => const ErrorScreen(),
    // You can replace ErrorScreen with your custom error screen
  );
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text(''),
          ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'An error occurred',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sorry, an error occurred while navigating.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
