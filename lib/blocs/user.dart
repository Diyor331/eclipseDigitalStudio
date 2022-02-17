import 'dart:developer';

import 'package:eclipse_digital_studio_test/models/models.dart';
import 'package:eclipse_digital_studio_test/services/repositories.dart';
import 'package:eclipse_digital_studio_test/util/env.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;


  UserState get initialState => UserLoadingState();

  UserBloc(this.userRepository) : super(UserLoadingState()) {
    on<UserLoadEvent>((event, emit) async {
      await _getUsers(emit);
    });
  }

  Future<void> _getUsers(Emitter<UserState> emit) async {
    emit(UserLoadingState());
    try {
      final List<User> _loadedUserList = await userRepository.getAllUsers();

      db.put('user',_loadedUserList);

      emit(UserLoadedState(loadedUser: db.get('user')));


    } catch (e) {
      if (db.get('user') != null) {
        emit(UserLoadedState(
          loadedUser: db.get('user'),
        ));
      } else {
        emit(UserErrorState());
      }
    }
  }
}
//Bloc

//State
abstract class UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  List<dynamic> loadedUser;

  UserLoadedState({
    required this.loadedUser,
  });
}

class UserErrorState extends UserState {}
//State

//Event
abstract class UserEvent {}

class UserLoadEvent extends UserEvent {
  UserLoadEvent();
}
//Event
