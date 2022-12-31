import 'package:fedopia/features/auth/presentation/cubit/account_manager_cubit.dart';
import 'package:fedopia/features/auth/presentation/view/widget/account_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountManager extends StatelessWidget {
  const AccountManager({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildAccountManager();
  }

  Widget _buildAccountManager() {
    return BlocBuilder<AccountManagerCubit, AccountManagerState>(
      builder: (context, state) {
        if (state is AccountManagerInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AccountManagerSuccess) {
          return Column(
            children: [
              ...state.accounts.map((account) {
                return AccountTile(
                  account: account,
                  selected: account.acct == state.defaultAccountIdentifier,
                );
              }).toList(),
            ],
          );
        } else if (state is AccountManagerEmpty) {
          return const Text('No accounts');
        }

        return const SizedBox.shrink();
      },
    );
  }
}
