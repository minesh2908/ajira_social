import 'package:ajira_social/common/constants.dart';
import 'package:ajira_social/theme/theme_manager.dart';
import 'package:ajira_social/views/components/body_widget.dart';
import 'package:ajira_social/views/screens/post/bloc/post_bloc.dart';
import 'package:ajira_social/views/screens/post/comments_screen.dart';
import 'package:ajira_social/views/screens/profile/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPostScreen extends StatelessWidget {
  const MyPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, userState) {
        // TODO: implement listener
      },
      builder: (context, userState) {
        return BlocConsumer<PostBloc, PostState>(
          listener: (context, postState) {
            if (postState.status == PostStatus.failure ||
                userState.status == UserStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(postState.message!),
                  duration: const Duration(seconds: 5),
                ),
              );
            }
          },
          builder: (context, postState) {
            return BodyWidget(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Posts'),
                  centerTitle: true,
                ),
                body: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CommentsScreen(
                                id: index,
                                postModal: postState.postModal![index],
                              );
                            },
                          ),
                        );
                      },
                      child: Padding(
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
                              title: Text(userState.userModal!.name ?? ''),
                              subtitle: Text(
                                '@${userState.userModal!.username}' ?? '',
                              ),
                            ),
                            Text(
                              postState.postModal?[index].title ?? '',
                              style: context.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              postState.postModal?[index].body ?? '',
                              style: context.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline,
                                  color: Colors.blue,
                                ),
                                Icon(
                                  Icons.favorite_outline,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
