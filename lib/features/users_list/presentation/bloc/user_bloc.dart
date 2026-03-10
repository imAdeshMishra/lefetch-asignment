import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_users.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase _getUsersUseCase;

  UserBloc(this._getUsersUseCase) : super(UserLoading()) {
    on<GetUsersEvent>(_onGetUsers);
  }

  void _onGetUsers(GetUsersEvent event, Emitter<UserState> emit) async {
  emit(UserLoading());

  final dataState = await _getUsersUseCase();

  if (dataState.data != null) {
    emit(UserLoaded(dataState.data!));
  } else {
    print(dataState.error);   
    emit(UserError("Failed to fetch users"));
  }
}
}