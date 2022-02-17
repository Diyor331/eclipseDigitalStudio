import 'package:eclipse_digital_studio_test/models/models.dart';
import 'package:eclipse_digital_studio_test/services/repositories.dart';
import 'package:eclipse_digital_studio_test/util/env.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Bloc
class AlbumDetailBloc extends Bloc<AlbumDetailEvent, AlbumDetailState> {
  final AlbumDetailRepository albumDetailRepository;

  AlbumDetailState get initialState => AlbumDetailLoadingState();

  AlbumDetailBloc(this.albumDetailRepository) : super(AlbumDetailLoadingState()) {
    on<AlbumDetailLoadEvent>((event, emit) async {
      await _getAlbumDetail(event, emit);
    });
  }

  Future<void> _getAlbumDetail(AlbumDetailLoadEvent event, Emitter<AlbumDetailState> emit) async {
    emit(AlbumDetailLoadingState());
    try {
      final List<AlbumDetail> _loadedAlbumDetailList = await albumDetailRepository.getAlbumDetail(event.albumId);

      db.put('albumDetail', _loadedAlbumDetailList);
      emit(AlbumDetailLoadedState(
        loadedAlbumDetail: db.get('albumDetail'),
      ));
    } catch (e) {
      if (db.get('albumDetail') != null) {
        emit(AlbumDetailLoadedState(
          loadedAlbumDetail: db.get('albumDetail'),
        ));
      } else {
        emit(AlbumDetailErrorState());
      }
    }
  }
}
//Bloc

//State
abstract class AlbumDetailState {}

class AlbumDetailLoadingState extends AlbumDetailState {}

class AlbumDetailLoadedState extends AlbumDetailState {
  List<dynamic> loadedAlbumDetail;

  AlbumDetailLoadedState({
    required this.loadedAlbumDetail,
  });
}

class AlbumDetailErrorState extends AlbumDetailState {}
//State

//Event
abstract class AlbumDetailEvent {}

class AlbumDetailLoadEvent extends AlbumDetailEvent {
  final dynamic albumId;

  AlbumDetailLoadEvent(this.albumId);
}
//Event
