import 'dart:async';

import 'package:ajira_social/get_it.dart';
import 'package:ajira_social/modals/comment_modal.dart';
import 'package:ajira_social/modals/post_modal.dart';
import 'package:ajira_social/repository/comment_repository.dart';
import 'package:ajira_social/repository/post_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState.initial()) {
    on<PostEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetPostsByUser>(_getPostByUser);
    on<GetCommentsOnPost>(_getCommentsOnPost);
  }
  final postRepo = getIt<PostRepository>();
  final commentRepo = getIt<CommentRepository>();
  FutureOr<void> _getPostByUser(
    GetPostsByUser event,
    Emitter<PostState> emit,
  ) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      final result = await postRepo.getPostDetails();
      emit(state.copyWith(status: PostStatus.success, postModal: result));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  FutureOr<void> _getCommentsOnPost(
    GetCommentsOnPost event,
    Emitter<PostState> emit,
  ) async {
    emit(
      state.copyWith(
        status: PostStatus.loading,
      ),
    );
    try {
      final response = await commentRepo.getComments(event.id);
      emit(state.copyWith(status: PostStatus.loading, commentModal: response));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
