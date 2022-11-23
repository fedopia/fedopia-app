part of 'account_picker_cubit.dart';

abstract class AccountPickerState extends Equatable {
  final List<Account> accounts;
  final String? selectedAccount;

  const AccountPickerState(this.accounts, this.selectedAccount);

  @override
  List<Object?> get props => [accounts, selectedAccount];
}

class AccountPickerInitial extends AccountPickerState {
  const AccountPickerInitial(List<Account> accounts, String? selectedAccount)
      : super(accounts, selectedAccount);
}
