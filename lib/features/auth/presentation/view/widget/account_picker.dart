import 'package:fedopia/features/auth/presentation/cubit/account_picker_cubit.dart';
import 'package:fedopia/features/auth/presentation/view/widget/account_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPicker extends StatelessWidget {
  const AccountPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountPickerCubit()..getAccounts(),
      child: _buildAccountPicker(),
    );
  }

  Widget _buildAccountPicker() {
    return BlocBuilder<AccountPickerCubit, AccountPickerState>(
      builder: (context, state) {
        return Column(
          children: [
            ...state.accounts.map((account) {
              return AccountTile(
                account: account,
                selected: account.acct == state.selectedAccount,
              );
            }).toList(),
          ],
        );
      },
    );
  }
}
