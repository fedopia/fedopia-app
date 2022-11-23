import 'package:fedopia/core/constants/app_constants.dart';
import 'package:fedopia/core/data/router.dart';
import 'package:fedopia/features/auth/data/entities/account_entity.dart';
import 'package:fedopia/features/auth/data/vaults/account_vault.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<AccountEntity>>? _accountsFuture;

  @override
  void initState() {
    _accountsFuture = AccountVault.getAccounts();
    super.initState();
  }

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
              FedopiaRouter.router.go(FedopiaRouter.instancePicker);
            },
            child: Text(AppLocalizations.of(context)!.login),
          ),
          FutureBuilder<List<AccountEntity>>(
            future: _accountsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final account = snapshot.data![index];
                    return ListTile(
                      title: Text(account.acct),
                      subtitle: Text(DateTime.fromMillisecondsSinceEpoch(
                        (account.token?.createdAt ?? 0) * 1000,
                      ).toString()),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(account.avatar),
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
