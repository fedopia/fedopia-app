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
        create: (context) => AuthBloc(),
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
        return _buildBody(state);
      },
    );
  }

  Center _buildBody(AuthState state) {
    if (state is AuthInitial) {
      return const Center(
        child: Text('Select an instance'),
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
