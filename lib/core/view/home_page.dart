import 'package:fedopia/core/data/constants/app_constants.dart';
import 'package:fedopia/core/data/router.dart';
import 'package:fedopia/features/auth/presentation/view/widget/account_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.title),
      ),
      body: ListView(
        children: [
          TextButton(
            onPressed: () {
              FedopiaRouter.router.push(FedopiaRouter.instancePicker);
            },
            child: Text(AppLocalizations.of(context)!.login),
          ),
          const AccountManager(),
        ],
      ),
    );
  }
}
