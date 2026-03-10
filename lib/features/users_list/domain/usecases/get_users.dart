import 'package:lafetch/core/resources/data_state.dart';
import 'package:lafetch/features/users_list/domain/entities/user.dart';
import 'package:lafetch/features/users_list/domain/repository/user_repository.dart';

class GetUsersUseCase {
  final UserRepository _userRepository;

  GetUsersUseCase(this._userRepository);

  Future<DataState<List<UserEntity>>> call() async {
    return await _userRepository.getUsers();
  }
}