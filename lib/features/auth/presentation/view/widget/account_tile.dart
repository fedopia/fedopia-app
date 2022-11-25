import 'package:cached_network_image/cached_network_image.dart';
import 'package:fedopia/features/auth/domain/model/account.dart';
import 'package:fedopia/features/auth/presentation/cubit/account_picker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    Key? key,
    required this.account,
    this.selected = false,
  }) : super(key: key);

  final Account account;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountPickerCubit, AccountPickerState>(
      builder: (context, state) {
        return ListTile(
          title: Text(account.acct),
          subtitle: Text(DateTime.fromMillisecondsSinceEpoch(
            (account.token?.createdAt ?? 0) * 1000,
          ).toString()),
          leading: CachedNetworkImage(
            imageUrl: account.avatar,
            placeholder: (context, url) => const CircularProgressIndicator(),
            imageBuilder: (context, imageProvider) {
              return CircleAvatar(backgroundImage: imageProvider);
            },
          ),
          trailing: selected
              ? const Icon(Icons.check_circle, color: Colors.green)
              : null,
          onTap: () {
            context.read<AccountPickerCubit>().setDefaultAccount(account.acct);
          },
        );
      },
    );
  }
}
