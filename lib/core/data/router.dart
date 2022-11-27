import 'package:fedopia/core/view/home_page.dart';
import 'package:fedopia/features/auth/presentation/cubit/account_picker_cubit.dart';
import 'package:fedopia/features/auth/presentation/view/auth_page.dart';
import 'package:fedopia/features/auth/presentation/view/instance_picker_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FedopiaRouter {
  FedopiaRouter._();

  static const String home = '/';
  static const String instancePicker = '/instance-picker';
  static String auth([String? instanceHost]) =>
      '/auth/${instanceHost ?? ":instanceHost"}';

  static Widget _homePageBuilder(BuildContext context, GoRouterState state) =>
      const HomePage();
  static Widget _authPageBuilder(BuildContext context, GoRouterState state) =>
      AuthPage(
        key: ValueKey(
          state.queryParams['code'] ?? state.params["instanceHost"],
        ),
        instanceHost: state.params["instanceHost"]!,
        code: state.queryParams["code"],
      );
  static Widget _instancePickerPageBuilder(
          BuildContext context, GoRouterState state) =>
      const InstancePickerPage();

  static GoRouter get router => _router;
  static final GoRouter _router = GoRouter(
    initialLocation: home,
    routes: <GoRoute>[
      GoRoute(path: home, builder: _homePageBuilder),
      GoRoute(path: instancePicker, builder: _instancePickerPageBuilder),
      GoRoute(path: auth(), builder: _authPageBuilder),
    ],
    redirect: (context, state) {
      final state = context.read<AccountPickerCubit>().state;
      if (state is AccountPickerEmpty) {
        return instancePicker;
      }
      return null;
    },
    debugLogDiagnostics: kDebugMode,
  );
}
