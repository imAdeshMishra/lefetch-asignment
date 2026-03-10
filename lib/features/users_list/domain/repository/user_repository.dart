import 'package:lafetch/core/resources/data_state.dart';
import 'package:lafetch/features/users_list/domain/entities/user.dart';

abstract class UserRepository {
  Future<DataState<List<UserEntity>>> getUsers();
}