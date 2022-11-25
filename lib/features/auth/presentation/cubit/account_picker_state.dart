part of 'account_picker_cubit.dart';

abstract class AccountPickerState extends Equatable {
  const AccountPickerState();

  @override
  List<Object?> get props => [];
}

class AccountPickerInProgress extends AccountPickerState {}

class AccountPickerSuccess extends AccountPickerState {
  final Iterable<Account> accounts;
  final String? defaultAccountIdentifier;

  const AccountPickerSuccess(this.accounts, this.defaultAccountIdentifier);

  @override
  List<Object?> get props => [accounts, defaultAccountIdentifier];
}

class AccountPickerEmpty extends AccountPickerState {}
