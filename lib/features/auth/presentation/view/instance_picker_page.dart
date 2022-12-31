import 'package:dio/dio.dart';
import 'package:fedopia/core/view/app_loading_page.dart';
import 'package:fedopia/features/auth/data/client/instances_client.dart';
import 'package:fedopia/features/auth/data/client/instances_endpoints.dart';
import 'package:fedopia/features/auth/data/repository/instances_repository.dart';
import 'package:fedopia/features/auth/domain/model/instance_type.dart';
import 'package:fedopia/features/auth/domain/usecase/instance_picker_usecase.dart';
import 'package:fedopia/features/auth/presentation/bloc/instance_picker/instance_picker_bloc.dart';
import 'package:fedopia/features/auth/presentation/view/widget/instance_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstancePickerPage extends StatelessWidget {
  const InstancePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instance Picker'),
      ),
      body: BlocProvider(
        create: (context) => InstancePickerBloc(
          InstancePickerUseCase(
            InstancesRepository(
              InstancesClient(
                Dio(BaseOptions(baseUrl: InstancesEndpoints.baseUrl)),
              ),
            ),
          ),
        ),
        child: BlocBuilder<InstancePickerBloc, InstancePickerState>(
          builder: (context, state) {
            return _buildInstancePickerBody(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildInstancePickerBody(
      BuildContext context, InstancePickerState state) {
    if (state is InstancePickerInitial) {
      final searchController = TextEditingController();
      return ListView(
        children: [
          const Text('Please enter an instance domain'),
          TextField(
            controller: searchController,
            onSubmitted: (value) => context.read<InstancePickerBloc>().add(
                  InstancePickerSearchStarted(
                    query: value,
                  ),
                ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.read<InstancePickerBloc>().add(
                  InstancePickerSearchStarted(
                    query: searchController.text,
                  ),
                ),
          ),
        ],
      );
    } else if (state is InstancePickerInProgress) {
      return const AppLoadingPage();
    } else if (state is InstancePickerSearchSuccess) {
      return ListView(
        children: state.instances
            .map((instance) => InstanceTile(instance: instance))
            .toList(),
      );
    } else if (state is InstancePickerSearchFailure) {
      return const Center(
        child: Text('Failed to load instances'),
      );
    } else {
      return const Center(
        child: Text('Unknown state'),
      );
    }
  }
}
