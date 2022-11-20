import 'package:fedopia/core/view/home_page.dart';
import 'package:fedopia/features/auth/presentation/view/auth_page.dart';
import 'package:fedopia/features/auth/presentation/view/instance_picker_page.dart';

class AppRoutePaths {
  AppRoutePaths._();

  static const String home = '/';
  static const String auth = '/auth';
  static const String instancePicker = '/instance-picker';
}

final fedopiaAppRoutes = {
  AppRoutePaths.home: (context) => const HomePage(),
  AppRoutePaths.auth: (context) => const AuthPage(),
  AppRoutePaths.instancePicker: (context) => const InstancePickerPage(),
};
