import 'package:eclipse_digital_studio_test/models/models.dart';
import 'package:eclipse_digital_studio_test/services/repositories.dart';
import 'package:eclipse_digital_studio_test/util/env.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Bloc
class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final PostDetailRepository postDetailRepository;

  PostDetailState get initialState => PostDetailLoadingState();

  PostDetailBloc(this.postDetailRepository) : super(PostDetailLoadingState()) {
    on<PostDetailLoadEvent>((event, emit) async {
      await _getPostDetail(event, emit);
    });
  }

  Future<void> _getPostDetail(PostDetailLoadEvent event, Emitter<PostDetailState> emit) async {
    emit(PostDetailLoadingState());
    try {
      final List<PostDetail> _loadedPostDetailList = await postDetailRepository.getPostDetail(event.postId);

      db.put('postDetail', _loadedPostDetailList);
      emit(PostDetailLoadedState(
        loadedPostDetail: db.get('postDetail'),
      ));
    } catch (e) {
      if (db.get('postDetail') != null) {
        emit(PostDetailLoadedState(
          loadedPostDetail: db.get('postDetail'),
        ));
      } else {
        emit(PostDetailErrorState());
      }
    }
  }
}
//Bloc

//State
abstract class PostDetailState {}

class PostDetailLoadingState extends PostDetailState {}

class PostDetailLoadedState extends PostDetailState {
  List<dynamic> loadedPostDetail;

  PostDetailLoadedState({
    required this.loadedPostDetail,
  });
}

class PostDetailErrorState extends PostDetailState {}
//State

//Event
abstract class PostDetailEvent {}

class PostDetailLoadEvent extends PostDetailEvent {
  final dynamic postId;

  PostDetailLoadEvent(this.postId);
}
//Event
