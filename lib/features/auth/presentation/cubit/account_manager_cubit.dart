import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fedopia/core/data/shared_prefs/fedopia_shared_prefs.dart';
import 'package:fedopia/features/auth/data/vaults/account_vault.dart';
import 'package:fedopia/features/auth/domain/model/account.dart';
import 'package:fedopia/features/auth/domain/translator/account_translator.dart';
import 'package:flutter/foundation.dart';

part 'account_manager_state.dart';

class AccountManagerCubit extends Cubit<AccountManagerState> {
  AccountManagerCubit() : super(AccountManagerInProgress());

  // get accounts
  Future<void> getAccounts() async {
    emit(AccountManagerInProgress());
    if (kDebugMode) await Future.delayed(const Duration(seconds: 1));

    final defaultAccountIdentifier =
        await FedopiaSharedPreferences.getDefaultAccountIdentifier();
    final accountEntities = await AccountVault.getAccounts();
    final accounts = accountEntities
        .map((accountEntity) => AccountTranslator.toModel(accountEntity))
        .toList();

    if (accounts.isEmpty) {
      emit(AccountManagerEmpty());
    } else {
      emit(AccountManagerSuccess(accounts, defaultAccountIdentifier));
    }
  }

  void setDefaultAccount(String identifier) async {
    final result = await FedopiaSharedPreferences.setDefaultAccount(identifier);
    if (result && state is AccountManagerSuccess) {
      emit(AccountManagerSuccess(
        (state as AccountManagerSuccess).accounts,
        identifier,
      ));
    }
  }
}
