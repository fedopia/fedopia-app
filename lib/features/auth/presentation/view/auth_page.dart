import 'package:dio/dio.dart';
import 'package:fedopia/core/widgets/app_error.dart';
import 'package:fedopia/core/widgets/centered_progress_bar.dart';
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
    final instance = ModalRoute.of(context)!.settings.arguments as Instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: BlocProvider(
        // TODO: Use a real client
        // TODO: Use a real repository
        create: (context) => AuthBloc(
          authRepository: AuthRepository(AuthClient(
            Dio(BaseOptions(
              baseUrl: instance.apiUri.toString(),
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
            )),
          )),
          instance: instance,
        )..add(const AuthStarted()),
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
        children: const [
          Text('Auth Initial'),
        ],
      );
    } else if (state is AuthInProgress) {
      return const CenteredProgressIndicator();
    } else if (state is AuthFailure) {
      return AppError(state.message);
    } else {
      return const Center(
        child: Text('Unknown state'),
      );
    }
  }
}
