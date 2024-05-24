part of 'album_bloc.dart'; // Indicates this file is part of the album_bloc.dart file

// Enum representing different states of the Album: initial, loading, success, failure
enum AlbumStatus { initial, loading, success, failure }

// Immutable state class for the Album feature, extends Equatable for easy comparison
class AlbumState extends Equatable {
  const AlbumState({
    this.albumModal, // List of AlbumModal objects
    this.message, // Message to display in case of an error
    this.status, // Current status of the album (initial, loading, success, failure)
    this.photosModal, // List of PhotosModal objects
  });

  // Factory constructor for the initial state of AlbumState
  factory AlbumState.initial() {
    return const AlbumState(
      status: AlbumStatus.initial,
    ); // Initial state with status set to initial
  }

  final List<AlbumModal?>? albumModal; // List of albums
  final List<PhotosModal?>? photosModal; // List of photos in an album
  final String? message; // Error or status message
  final AlbumStatus? status; // Current status of the album

  // Method to create a copy of AlbumState with new values, retaining old values for fields not passed in
  AlbumState copywith({
    List<AlbumModal?>? albumModal,
    List<PhotosModal?>? photosModal,
    String? message,
    AlbumStatus? status,
  }) {
    return AlbumState(
      albumModal: albumModal ??
          this.albumModal, // Use new albumModal if provided, else retain old
      photosModal: photosModal ??
          this.photosModal, // Use new photosModal if provided, else retain old
      message: message ??
          this.message, // Use new message if provided, else retain old
      status:
          status ?? this.status, // Use new status if provided, else retain old
    );
  }

  @override
  List<Object?> get props => [
        albumModal,
        photosModal,
        message,
        status,
      ]; // List of properties used for equality comparison
}
