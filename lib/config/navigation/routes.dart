// ignore_for_file: constant_identifier_names

class RouteName {
  RouteName._();
  static Future<String> get initialRoute async {
    return SPLASH;
  }

  static const SPLASH = '/';
  static const ONBOARDING = '/onboarding';
  static const AUTHENTICATION = '/authentication';
  static const Dashboard = '/dashboard';
  static const Auth = '/auth';
  static const Home = '/dashboard/home';
  static const Profile = '/dashboard/profile';
  static const EmployeeProfile = '/employeeProfile';
  static const EmployeeList = '/dashboard/employeeList';
  static const AttendanceList = '/dashboard/home/attendanceList';
  static const LeaveList = '/dashboard/home/leaveList';
}
