import 'package:fedopia/core/constants/app_constants.dart';
import 'package:fedopia/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppTitle),
      ),
      body: Column(
        children: [
          Text(AppLocalizations.of(context)!.home),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutePaths.auth);
            },
            child: Text(AppLocalizations.of(context)!.login),
          ),
        ],
      ),
    );
  }
}
