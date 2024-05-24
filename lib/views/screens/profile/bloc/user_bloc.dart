import 'dart:async';

import 'package:ajira_social/get_it.dart';
import 'package:ajira_social/modals/user_modal.dart';
import 'package:ajira_social/repository/user_repository.dart';
import 'package:ajira_social/service/location_permission.dart';
import 'package:ajira_social/service/pick_image.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState.initial()) {
    on<GetUserDetailsEvent>(_getUserDetailsEvent);
    on<GetUserCurrenctLocationEvent>(_getUserCurrenctLocation);
    on<GetImageFromCameraEvent>(_getImageFromCameraEvent);
    on<GetImageFromGalleryEvent>(_getImageFromGalleryEvent);
  }

  final userRepository = getIt<UserRepository>();

  FutureOr<void> _getUserDetailsEvent(
    GetUserDetailsEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      final response = await userRepository.getUserDetail();
      emit(state.copyWith(status: UserStatus.success, userModal: response));
      print(response);
    } catch (e) {
      emit(state.copyWith(status: UserStatus.failure, message: e.toString()));
    }
  }

  FutureOr<void> _getUserCurrenctLocation(
    GetUserCurrenctLocationEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));

    try {
      final currentPosition =
          await CheckLocationPermission().getCurrentPosition();
      //print(currentPosition);
      final currentAddress = await CheckLocationPermission()
          .getAddressFromLatLng(currentPosition!);
      //print(currentAddress);
      final addressModal = Address(
        street: currentAddress!.subLocality,
        city: '${currentAddress.name}, ${currentAddress.country}',
        zipcode: currentAddress.postalCode,
        geo: Geo(
          lat: currentPosition.latitude.toString(),
          lng: currentPosition.longitude.toString(),
        ),
      );
      final usermModal = state.userModal?.copyWith(address: addressModal);

      emit(
        state.copyWith(
          status: UserStatus.success,
          userModal: usermModal,
        ),
      );
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: UserStatus.failure));
    }
  }

  FutureOr<void> _getImageFromCameraEvent(
    GetImageFromCameraEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      print('camera called');

      final image = await PickImage().pickImageFromCamera();
      final userModal = state.userModal?.copyWith(image: image);

      emit(
        state.copyWith(
          status: UserStatus.success,
          userModal: userModal,
        ),
      );
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: UserStatus.failure));
    }
  }

  FutureOr<void> _getImageFromGalleryEvent(
    GetImageFromGalleryEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      print('gallery called');
      final image = await PickImage().pickImageFromGalllery();
      final userModal = state.userModal?.copyWith(image: image);

      emit(
        state.copyWith(
          status: UserStatus.success,
          userModal: userModal,
        ),
      );
    } catch (e) {
      emit(state.copyWith(message: e.toString(), status: UserStatus.failure));
    }
  }
}
