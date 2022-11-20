import 'package:fedopia/core/view/home_page.dart';
import 'package:fedopia/features/auth/presentation/view/auth_page.dart';

class AppRoutePaths {
  static const String home = '/';
  static const String auth = '/auth';
}

final fedopiaAppRoutes = {
  AppRoutePaths.home: (context) => const HomePage(),
  AppRoutePaths.auth: (context) => const AuthPage(),
};
