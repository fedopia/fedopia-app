import 'package:fedopia/core/routes.dart';
import 'package:fedopia/features/auth/domain/model/instance.dart';
import 'package:flutter/material.dart';

class InstancePickerPage extends StatelessWidget {
  const InstancePickerPage({super.key});

  static const List<Instance> instances = [
    Instance(name: 'mastodon.social', host: 'mastodon.social'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instance Picker'),
      ),
      body: ListView(
        children: [
          const Text('Select an instance'),
          ...instances.map(
            (instance) => TextButton(
              child: Text(instance.name),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutePaths.auth,
                  arguments: instance,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
