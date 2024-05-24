// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPostsByUser extends PostEvent {}

class GetCommentsOnPost extends PostEvent {
  int id;
  GetCommentsOnPost({
    required this.id,
  });
}
