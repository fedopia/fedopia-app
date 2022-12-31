import 'package:dio/dio.dart';
import 'package:fedopia/core/widgets/app_error.dart';
import 'package:fedopia/core/widgets/centered_progress_bar.dart';
import 'package:fedopia/features/auth/data/client/auth_api_client.dart';
import 'package:fedopia/features/auth/data/client/auth_client.dart';
import 'package:fedopia/features/auth/data/repository/auth_repository.dart';
import 'package:fedopia/features/auth/domain/domain.dart';
import 'package:fedopia/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AuthPage extends StatelessWidget {
  final String instanceHost;
  final String? code;
  const AuthPage({super.key, required this.instanceHost, this.code});

  @override
  Widget build(BuildContext context) {
    final instance = Instance.fromHost(instanceHost);

    const headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(
          authUseCase: AuthUseCase(AuthRepository(
            AuthClient(
              Dio(
                BaseOptions(
                  baseUrl: instance.uri.toString(),
                  headers: headers,
                ),
              )..interceptors.add(PrettyDioLogger()),
            ),
            AuthApiClient(
              Dio(
                BaseOptions(
                  baseUrl: instance.apiUri.toString(),
                  headers: headers,
                ),
              )..interceptors.add(PrettyDioLogger()),
            ),
          )),
          instance: instance,
        )..add(code == null ? AuthStarted() : AuthStartedWithCode(code: code!)),
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
