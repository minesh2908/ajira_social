part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserDetailsEvent extends UserEvent {}

class GetUserCurrenctLocationEvent extends UserEvent {}

class GetImageFromGalleryEvent extends UserEvent {}

class GetImageFromCameraEvent extends UserEvent {}
