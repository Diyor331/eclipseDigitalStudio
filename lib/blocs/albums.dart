import 'package:eclipse_digital_studio_test/models/models.dart';
import 'package:eclipse_digital_studio_test/services/repositories.dart';
import 'package:eclipse_digital_studio_test/services/services.dart';
import 'package:eclipse_digital_studio_test/util/env.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Bloc
class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  final AlbumsRepository albumsRepository;

  AlbumsState get initialState => AlbumsLoadingState();

  AlbumsBloc(this.albumsRepository) : super(AlbumsLoadingState()) {
    on<AlbumsLoadEvent>((event, emit) async {
      await _getAlbums(event, emit);
    });
  }

  Future<void> _getAlbums(AlbumsLoadEvent event, Emitter<AlbumsState> emit) async {
    emit(AlbumsLoadingState());
    try {
      final List<Albums> _loadedAlbumsList = await albumsRepository.getAlbums(event.userId);

      db.put('albums', _loadedAlbumsList);
      emit(AlbumsLoadedState(
        loadedAlbums: db.get('albums'),
      ));
    } catch (e) {
      if (db.get('albums') != null) {
        emit(AlbumsLoadedState(
          loadedAlbums: db.get('albums'),
        ));
      } else {
        emit(AlbumsErrorState());
      }
    }
  }
}
//Bloc

//State
abstract class AlbumsState {}

class AlbumsLoadingState extends AlbumsState {}

class AlbumsLoadedState extends AlbumsState {
  List<dynamic> loadedAlbums;

  AlbumsLoadedState({
    required this.loadedAlbums,
  });
}

class AlbumsErrorState extends AlbumsState {}
//State

//Event
abstract class AlbumsEvent {}

class AlbumsLoadEvent extends AlbumsEvent {
  final dynamic userId;

  AlbumsLoadEvent(this.userId);
}
//Event
