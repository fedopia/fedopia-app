import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:bloc/bloc.dart';
import 'package:fedopia/core/constants/app_constants.dart';
import 'package:fedopia/core/data/router.dart';
import 'package:fedopia/core/model/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  runApp(const FedopiaApp());

  Bloc.observer = SimpleBlocObserver();

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
}

void _onNewAuthLink(Uri uri) {
  log('New auth request received: ${uri.toString()}');
  FedopiaRouter.router.replace(uri.path);
  closeInAppWebView();
}

class FedopiaApp extends StatelessWidget {
  const FedopiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: FedopiaRouter.router,
      title: AppConstants.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
    );
  }
}
