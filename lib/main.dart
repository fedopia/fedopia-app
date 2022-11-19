import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const FedopiaApp());
}

class FedopiaApp extends StatelessWidget {
  const FedopiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fedopia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Builder(builder: (context) {
        return Scaffold(
          body: Center(
            child: Text(AppLocalizations.of(context)!.home),
          ),
        );
      }),
    );
  }
}
