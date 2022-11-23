import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fedopia/core/data/shared_prefs/fedopia_shared_prefs.dart';
import 'package:fedopia/features/auth/data/vaults/account_vault.dart';
import 'package:fedopia/features/auth/domain/model/account.dart';
import 'package:fedopia/features/auth/domain/translator/account_translator.dart';

part 'account_picker_state.dart';

class AccountPickerCubit extends Cubit<AccountPickerState> {
  AccountPickerCubit() : super(const AccountPickerInitial([], null));

  // get accounts
  Future<void> getAccounts() async {
    final selectedAccount = await FedopiaSharedPreferences.getDefaultAccount();
    final accountEntities = await AccountVault.getAccounts();
    final accounts = accountEntities
        .map((accountEntity) => AccountTranslator.toModel(accountEntity))
        .toList();
    emit(AccountPickerInitial(accounts, selectedAccount));
  }

  void selectAccount(String identifier) async {
    final result = await FedopiaSharedPreferences.setDefaultAccount(identifier);
    if (result) {
      emit(AccountPickerInitial(state.accounts, identifier));
    }
  }
}
