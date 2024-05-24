part of 'album_bloc.dart';

class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

class GetAlbumEvent extends AlbumEvent {}

class GetAlbumPhotoDetailEvent extends AlbumEvent {
  GetAlbumPhotoDetailEvent({
    this.id,
  });
  int? id;
}
