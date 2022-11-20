import 'package:dio/dio.dart';
import 'package:fedopia/features/auth/data/client/auth_client.dart';
import 'package:fedopia/features/auth/data/repository/auth_repository.dart';
import 'package:fedopia/features/auth/domain/model/instance.dart';
import 'package:fedopia/features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: BlocProvider(
        // TODO: Use a real client
        // TODO: Use a real repository
        create: (context) => AuthBloc(AuthRepository(AuthClient(Dio()))),
        child: const AuthPageBody(),
      ),
    );
  }
}

class AuthPageBody extends StatelessWidget {
  const AuthPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return _buildBody(context, state);
      },
    );
  }

  Widget _buildBody(BuildContext context, AuthState state) {
    if (state is AuthInitial) {
      return Column(
        children: [
          const Text('Select an instance'),
          TextButton(
            onPressed: () {
              const instance = Instance(
                name: 'mastodon.social',
                domain: 'mastodon.social',
              );
              context.read<AuthBloc>().add(const InstanceSelected(instance));
            },
            child: const Text('Select'),
          ),
        ],
      );
    } else if (state is AuthInstanceSelectSuccess) {
      return Center(
        child: Text('Selected instance: ${state.instance.name}'),
      );
    } else {
      return const Center(
        child: Text('Unknown state'),
      );
    }
  }
}
