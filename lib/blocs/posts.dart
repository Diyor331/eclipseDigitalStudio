import 'package:eclipse_digital_studio_test/models/models.dart';
import 'package:eclipse_digital_studio_test/services/repositories.dart';
import 'package:eclipse_digital_studio_test/util/env.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Bloc
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;

  PostsState get initialState => PostsLoadingState();

  PostsBloc(this.postsRepository) : super(PostsLoadingState()) {
    on<PostsLoadEvent>((event, emit) async {
      await _getPosts(event, emit);
    });
  }

  Future<void> _getPosts(PostsLoadEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());
    try {
      final List<Posts> _loadedPostsList = await postsRepository.getPosts(event.userId);

      db.put('posts', _loadedPostsList);

      emit(PostsLoadedState(
        loadedPosts: db.get('posts'),
      ));
    } catch (e) {
      if (db.get('posts') != null) {
        emit(PostsLoadedState(
          loadedPosts: db.get('posts'),
        ));
      } else {
        emit(PostsErrorState());
      }
    }
  }
}
//Bloc

//State
abstract class PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedState extends PostsState {
  List<dynamic> loadedPosts;

  PostsLoadedState({
    required this.loadedPosts,
  });
}

class PostsErrorState extends PostsState {}
//State

//Event
abstract class PostsEvent {}

class PostsLoadEvent extends PostsEvent {
  final dynamic userId;

  PostsLoadEvent(this.userId);
}
//Event
