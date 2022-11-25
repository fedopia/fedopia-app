import 'package:fedopia/features/auth/presentation/cubit/account_picker_cubit.dart';
import 'package:fedopia/features/auth/presentation/view/widget/account_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPicker extends StatelessWidget {
  const AccountPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildAccountPicker();
  }

  Widget _buildAccountPicker() {
    return BlocBuilder<AccountPickerCubit, AccountPickerState>(
      builder: (context, state) {
        if (state is AccountPickerInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AccountPickerSuccess) {
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
        } else if (state is AccountPickerEmpty) {
          return const Text('No accounts');
        }

        return const SizedBox.shrink();
      },
    );
  }
}
