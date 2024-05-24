// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

enum PostStatus { initial, loading, success, failure }

class PostState extends Equatable {
  const PostState({
    this.message,
    this.status,
    this.postModal,
    this.commentModal,
  });

  factory PostState.initial() {
    return const PostState(status: PostStatus.initial);
  }
  final String? message;
  final PostStatus? status;
  final List<PostModal>? postModal;
  final List<CommentModal>? commentModal;
  PostState copyWith({
    String? message,
    PostStatus? status,
    List<PostModal>? postModal,
    List<CommentModal>? commentModal,
  }) {
    return PostState(
      message: message ?? this.message,
      postModal: postModal ?? this.postModal,
      status: status ?? this.status,
      commentModal: commentModal ?? this.commentModal,
    );
  }

  @override
  List<Object?> get props => [message, status, postModal, commentModal];
}
