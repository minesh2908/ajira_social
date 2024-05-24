// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

enum UserStatus { initial, loading, success, failure }

class UserState extends Equatable {
  const UserState({
    this.status,
    this.message,
    this.userModal,
    this.locality,
    this.city,
  });

  factory UserState.initial() {
    return const UserState(status: UserStatus.initial);
  }

  final UserStatus? status;
  final String? message;
  final UserModal? userModal;
  final String? locality;
  final String? city;

  UserState copyWith({
    UserStatus? status,
    String? message,
    UserModal? userModal,
    String? locality,
    String? city,
  }) {
    return UserState(
      status: status ?? this.status,
      message: message ?? this.message,
      userModal: userModal ?? this.userModal,
      locality: locality ?? this.locality,
      city: city ?? this.city,
    );
  }

  @override
  List<Object?> get props => [status, message, userModal, locality, city];
}
