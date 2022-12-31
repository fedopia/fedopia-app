import 'package:fedopia/core/data/router.dart';
import 'package:fedopia/features/auth/domain/model/instance.dart';
import 'package:flutter/material.dart';

class InstanceTile extends StatelessWidget {
  final Instance instance;
  const InstanceTile({
    Key? key,
    required this.instance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(instance.name),
      subtitle: Text('${instance.userCount} users'),
      onTap: () {
        FedopiaRouter.router.push(
          FedopiaRouter.auth(instance.host),
        );
      },
    );
  }
}
