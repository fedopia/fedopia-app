import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart';
import 'package:fedopia/core/data/constants/app_constants.dart';
import 'package:fedopia/core/data/router.dart';
import 'package:fedopia/core/model/simple_bloc_observer.dart';
import 'package:fedopia/core/view/app_loading_page.dart';
import 'package:fedopia/core/view/home_page.dart';
import 'package:fedopia/features/auth/presentation/cubit/account_picker_cubit.dart';
import 'package:fedopia/features/auth/presentation/view/instance_picker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> fedopiaAppRunner() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  final appLinks = AppLinks();
  // we shouldn't use the appLinks.getInitialLink() method here, because it
  // unnecessary as the app is not yet running and we only process
  // app links when the app is already running
  final uri = await appLinks.getInitialAppLink();
  if (uri != null) {
    // _onNewAuthLink(uri);
  }

  appLinks.uriLinkStream.listen((uri) {
    _onNewAuthLink(uri);
  });

  const app = FedopiaApp();
  runApp(app);
}

void main() async {
  await fedopiaAppRunner();
}

void _onNewAuthLink(Uri uri) {
  log('New auth request received: ${uri.toString()}');
  FedopiaRouter.router.replace(uri.path);
}

class FedopiaApp extends StatelessWidget {
  const FedopiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountPickerCubit>(
          create: (context) => AccountPickerCubit()..getAccounts(),
        ),
        // settings bloc
      ],
      child: MaterialApp.router(
        builder: (context, child) {
          final state = context.watch<AccountPickerCubit>().state;
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: state is AccountPickerInProgress
                  ? const AppLoadingPage()
                  : state is AccountPickerEmpty
                      ? const InstancePickerPage()
                      : child ?? const HomePage(),
            ),
          );
        },
        routerConfig: FedopiaRouter.router,
        title: AppConstants.title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
      ),
    );
  }
}
