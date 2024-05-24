import 'package:ajira_social/repository/album_repository.dart';
import 'package:ajira_social/repository/comment_repository.dart';
import 'package:ajira_social/repository/photos_repository.dart';
import 'package:ajira_social/repository/post_repository.dart';
import 'package:ajira_social/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt
    ..registerSingleton<UserRepository>(UserRepository())
    ..registerSingleton<AlbumRepository>(AlbumRepository())
    ..registerSingleton<PhotosRepository>(PhotosRepository())
    ..registerSingleton<PostRepository>(PostRepository())
    ..registerSingleton<CommentRepository>(CommentRepository());
}
