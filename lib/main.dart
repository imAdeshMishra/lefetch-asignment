import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafetch/features/users_list/data/data_sources/remote/user_api_service.dart';
import 'features/users_list/data/repository/user_repository_impl.dart';
import 'features/users_list/domain/usecases/get_users.dart';
import 'features/users_list/presentation/bloc/user_bloc.dart';
import 'features/users_list/presentation/bloc/user_event.dart';
import 'features/users_list/presentation/pages/user_list_page.dart';

void main() {

  final dio = Dio();

  final apiService = UserApiService(dio);

  final repository = UserRepositoryImpl(apiService);

  final getUsersUseCase = GetUsersUseCase(repository);

  runApp(
    BlocProvider(
      create: (context) => UserBloc(getUsersUseCase)..add(GetUsersEvent()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UsersList(),
    );
  }
}