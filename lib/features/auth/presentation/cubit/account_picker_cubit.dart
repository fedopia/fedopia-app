import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fedopia/core/data/shared_prefs/fedopia_shared_prefs.dart';
import 'package:fedopia/features/auth/data/vaults/account_vault.dart';
import 'package:fedopia/features/auth/domain/model/account.dart';
import 'package:fedopia/features/auth/domain/translator/account_translator.dart';
import 'package:flutter/foundation.dart';

part 'account_picker_state.dart';

class AccountPickerCubit extends Cubit<AccountPickerState> {
  AccountPickerCubit() : super(AccountPickerInProgress());

  // get accounts
  Future<void> getAccounts() async {
    emit(AccountPickerInProgress());
    if (kDebugMode) await Future.delayed(const Duration(seconds: 1));

    final defaultAccountIdentifier =
        await FedopiaSharedPreferences.getDefaultAccountIdentifier();
    final accountEntities = await AccountVault.getAccounts();
    final accounts = accountEntities
        .map((accountEntity) => AccountTranslator.toModel(accountEntity))
        .toList();

    if (accounts.isEmpty) {
      emit(AccountPickerEmpty());
    } else {
      emit(AccountPickerSuccess(accounts, defaultAccountIdentifier));
    }
  }

  void setDefaultAccount(String identifier) async {
    final result = await FedopiaSharedPreferences.setDefaultAccount(identifier);
    if (result && state is AccountPickerSuccess) {
      emit(AccountPickerSuccess(
        (state as AccountPickerSuccess).accounts,
        identifier,
      ));
    }
  }
}
