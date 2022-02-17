import 'dart:developer';

import 'package:eclipse_digital_studio_test/models/models.dart';
import 'package:eclipse_digital_studio_test/services/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eclipse_digital_studio_test/util/env.dart';

//Bloc
class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserDetailRepository userDetailRepository;
  final PostsRepository postsRepository;
  final AlbumsRepository albumsRepository;

  UserDetailState get initialState => UserDetailLoadingState();

  UserDetailBloc(this.userDetailRepository, this.postsRepository, this.albumsRepository) : super(UserDetailLoadingState()) {
    on<UserDetailLoadEvent>((event, emit) async {
      await _getUserDetails(event, emit);
    });
  }

  Future<void> _getUserDetails(UserDetailLoadEvent event, Emitter<UserDetailState> emit) async {
    emit(UserDetailLoadingState());
    try {
      final List<UserDetail> _loadedUserDetailList = await userDetailRepository.getUserById(event.id);

      final List<Posts> _loadedPostsList = await postsRepository.getPosts(event.id);

      final List<Albums> _loadedAlbumsList = await albumsRepository.getAlbums(event.id);

      db.put('userDetail', _loadedUserDetailList);
      db.put('posts', _loadedPostsList);
      db.put('albums', _loadedAlbumsList);

      emit(UserDetailLoadedState(
        loadedUserDetail: db.get('userDetail'),
        loadedPosts: db.get('posts'),
        loadedAlbums: db.get('albums'),
      ));
    } catch (e) {
      if (db.get('userDetail') != null && db.get('posts') != null && db.get('albums') != null) {
        emit(UserDetailLoadedState(
          loadedUserDetail: db.get('userDetail'),
          loadedPosts: db.get('posts'),
          loadedAlbums: db.get('albums'),
        ));
      } else {
        emit(UserDetailErrorState());
      }
    }
  }
}
//Bloc

//State
abstract class UserDetailState {}

class UserDetailLoadingState extends UserDetailState {}

class UserDetailLoadedState extends UserDetailState {
  List<dynamic> loadedUserDetail;
  List<dynamic> loadedPosts;
  List<dynamic> loadedAlbums;

  UserDetailLoadedState({
    required this.loadedUserDetail,
    required this.loadedPosts,
    required this.loadedAlbums,
  });
}

class UserDetailErrorState extends UserDetailState {}
//State

//Event
abstract class UserDetailEvent {}

class UserDetailLoadEvent extends UserDetailEvent {
  final dynamic id;

  UserDetailLoadEvent(this.id);
}
//Event
