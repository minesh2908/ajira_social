import 'package:ajira_social/common/constants.dart';
import 'package:ajira_social/modals/post_modal.dart';
import 'package:ajira_social/theme/theme_manager.dart';
import 'package:ajira_social/views/components/body_widget.dart';
import 'package:ajira_social/views/screens/post/bloc/post_bloc.dart';
import 'package:ajira_social/views/screens/profile/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({required this.id, required this.postModal, super.key});
  final int id;
  final PostModal postModal;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(
      bloc: context.read<PostBloc>()
        ..add(GetCommentsOnPost(id: postModal.id ?? 0)),
      listener: (context, postState) {
        if (postState.status == PostStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(postState.message!),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
      builder: (context, postState) {
        return BlocConsumer<UserBloc, UserState>(
          listener: (context, userState) {
            if (userState.status == UserStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(userState.message!),
                  duration: const Duration(seconds: 5),
                ),
              );
            }
          },
          builder: (context, userState) {
            return BodyWidget(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Comments'),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: horizontalPadding16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 30,
                          child: Text(
                            userState.userModal!.name!.substring(0, 1),
                            style: context.titleMedium,
                          ),
                        ),
                        title: Text(userState.userModal!.name! ?? ''),
                        subtitle:
                            Text('@${userState.userModal!.username!}' ?? ''),
                      ),
                      Text(
                        postModal.title ?? '',
                        style: context.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        postModal.body ?? '',
                        style: context.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      verticalMargin16,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.favorite_outline,
                            color: Colors.blue,
                          ),
                          Icon(
                            Icons.chat_bubble_outline,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      verticalMargin16,
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              indent: 12,
                              endIndent: 12,
                            ),
                          ),
                          Text(
                            'COMMENTS',
                            style: context.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const Expanded(
                            child: Divider(
                              indent: 12,
                              endIndent: 12,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: postState.commentModal?.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 25,
                                    child: Text(
                                      postState.commentModal?[index].name!
                                              .substring(0, 1) ??
                                          '',
                                      style: context.titleMedium,
                                    ),
                                  ),
                                  title: Text(
                                    postState.commentModal?[index].email ?? '',
                                  ),
                                  subtitle: Text(
                                    'Replying to ${userState.userModal!.username}' ??
                                        '',
                                  ),
                                ),
                                Text(
                                  postState.commentModal?[index].name ?? '',
                                  style: context.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  postState.commentModal?[index].body ?? '',
                                  style: context.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline,
                                      color: Colors.blue,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  indent: 12,
                                  endIndent: 12,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
