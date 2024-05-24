import 'dart:async'; 
import 'package:ajira_social/get_it.dart'; 
import 'package:ajira_social/modals/album_modal.dart'; 
import 'package:ajira_social/modals/photos_modal.dart'; 
import 'package:ajira_social/repository/album_repository.dart'; 
import 'package:ajira_social/repository/photos_repository.dart'; 
import 'package:bloc/bloc.dart'; 
import 'package:equatable/equatable.dart'; 
part 'album_event.dart'; 
part 'album_state.dart'; 

// BLoC class for managing album-related state and events
class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(AlbumState.initial()) {
    // Constructor initializes the Bloc with initial state and sets up event handlers
    on<AlbumEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetAlbumEvent>(_getAlbumEvent); // Event handler for GetAlbumEvent
    on<GetAlbumPhotoDetailEvent>(
      _getAlbumPhotoDetailEvent,
    ); // Event handler for GetAlbumPhotoDetailEvent
  }

  final albumRepository =
      getIt<AlbumRepository>(); // Instance of AlbumRepository
  final photosRepository =
      getIt<PhotosRepository>(); // Instance of PhotosRepository

  // Event handler for GetAlbumEvent
  FutureOr<void> _getAlbumEvent(
    GetAlbumEvent event,
    Emitter<AlbumState> emit,
  ) async {
    emit(state.copywith(status: AlbumStatus.loading)); // Emit loading state
    try {
      final response =
          await albumRepository.getAlbumDetails(); // Fetch album details
      emit(
        state.copywith(
          status: AlbumStatus.success,
          albumModal: response,
        ),
      ); // Emit success state with album details
    } catch (e) {
      emit(
        state.copywith(
          status: AlbumStatus.failure,
          message: e.toString(),
        ),
      ); // Emit failure state with error message
    }
  }

  // Event handler for GetAlbumPhotoDetailEvent
  FutureOr<void> _getAlbumPhotoDetailEvent(
    GetAlbumPhotoDetailEvent event,
    Emitter<AlbumState> emit,
  ) async {
    emit(state.copywith(status: AlbumStatus.loading)); // Emit loading state
    try {
      final response = await photosRepository
          .getUserPhotos(event.id); // Fetch user photos for the specified album
      emit(
        state.copywith(
          status: AlbumStatus.success,
          photosModal: response,
        ),
      ); // Emit success state with photos
    } catch (e) {
      emit(
        state.copywith(
          status: AlbumStatus.failure,
          message: e.toString(),
        ),
      ); // Emit failure state with error message
    }
  }
}
