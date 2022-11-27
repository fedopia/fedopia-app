part of 'account_manager_cubit.dart';

abstract class AccountManagerState extends Equatable {
  const AccountManagerState();

  @override
  List<Object?> get props => [];
}

class AccountManagerInProgress extends AccountManagerState {}

class AccountManagerSuccess extends AccountManagerState {
  final Iterable<Account> accounts;
  final String? defaultAccountIdentifier;

  const AccountManagerSuccess(this.accounts, this.defaultAccountIdentifier);

  @override
  List<Object?> get props => [accounts, defaultAccountIdentifier];
}

class AccountManagerEmpty extends AccountManagerState {}
