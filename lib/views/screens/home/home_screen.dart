import 'dart:io';

import 'package:ajira_social/common/constants.dart';
import 'package:ajira_social/theme/theme_manager.dart';
import 'package:ajira_social/views/components/body_widget.dart';
import 'package:ajira_social/views/screens/home/album_detail_screen.dart';
import 'package:ajira_social/views/screens/home/bloc/album_bloc.dart';
import 'package:ajira_social/views/screens/profile/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, userState) {
        print(userState.status);
      },
      builder: (context, userState) {
        return BlocConsumer<AlbumBloc, AlbumState>(
          listener: (context, albumState) {
            // Listener to handle state changes for AlbumBloc
            print(albumState.status);
            if (userState.status == UserStatus.failure ||
                albumState.status == AlbumStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(userState.message!),
                  duration: const Duration(seconds: 5),
                ),
              );
            }
          },
          builder: (context, albumState) {
            return BodyWidget(
              isLoading: albumState.status == AlbumStatus.loading ||
                  userState.status == UserStatus.loading,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    userState.userModal?.name! ?? '',
                  ), // Display user's name in app bar
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {
                              await commonAlertDialog(
                                userState,
                                context,
                                Icons.phone,
                                'Phone Number',
                                userState.userModal!.phone ??
                                    '', // Show phone number
                              );
                            },
                            child: const CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.call),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 45,
                                  child: userState.userModal?.image != null
                                      ? Image.file(
                                          width: 50,
                                          height: 50,
                                          File(
                                            userState.userModal!.image!.path,
                                          ),
                                        )
                                      : Text(
                                          userState.userModal?.name!.substring(
                                                0,
                                                1,
                                              ) ??
                                              '',
                                          style: context.displayLarge,
                                        ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet<dynamic>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: horizontalPadding12,
                                          child: Column(
                                            children: [
                                              Text(
                                                'Choose Photo',
                                                style: context.headlineSmall,
                                              ),
                                              const Divider(
                                                indent: 12,
                                                endIndent: 12,
                                              ),
                                              verticalMargin16,
                                              InkWell(
                                                onTap: () {
                                                  context.read<UserBloc>().add(
                                                        GetImageFromGalleryEvent(),
                                                      );
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.photo_library,
                                                      size: 25,
                                                    ),
                                                    horizontalMargin12,
                                                    Text(
                                                      'Pick image from gallery',
                                                      style: context.titleLarge,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              verticalMargin16,
                                              InkWell(
                                                onTap: () {
                                                  context.read<UserBloc>().add(
                                                        GetImageFromCameraEvent(),
                                                      );
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.camera_alt,
                                                    ),
                                                    horizontalMargin12,
                                                    Text(
                                                      'Pick image from Camera',
                                                      style: context.titleLarge,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              await commonAlertDialog(
                                userState,
                                context,
                                Icons.web,
                                'Website',
                                userState.userModal?.website! ?? '',
                              );
                            },
                            child: const CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.web),
                            ),
                          ),
                        ],
                      ),
                      verticalMargin16,
                      Text(
                        '@${userState.userModal?.username!}',
                        style: context.titleLarge,
                      ),
                      verticalMargin4,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<UserBloc>().add(
                                    GetUserCurrenctLocationEvent(),
                                  );
                            },
                            child: const Icon(
                              Icons.location_on,
                              size: 20,
                            ),
                          ),
                          Text(
                            userState.userModal?.address!.street ?? '',
                            style: context.titleMedium,
                          ),
                        ],
                      ),
                      verticalMargin4,
                      Text(
                        userState.userModal?.address!.city ?? '',
                        style: context.titleMedium,
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
                            'ALBUMS',
                            style: context.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              indent: 12,
                              endIndent: 12,
                            ),
                          ),
                        ],
                      ),
                      verticalMargin16,
                      Padding(
                        padding: horizontalPadding12,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: albumState.albumModal?.length ??
                              0, // Number of albums
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<dynamic>(
                                          builder: (context) =>
                                              AlbumDetailScreen(
                                            albumModal: albumState.albumModal?[
                                                index], 
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: context
                                            .secondaryContainer, 
                                      ),
                                      child: const Icon(
                                        Icons.folder_outlined, 
                                        size: 100,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  albumState.albumModal?[index]!.title ??
                                      '',
                                  style: context.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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

  Future<dynamic> commonAlertDialog(
    UserState userState,
    BuildContext context,
    IconData icon,
    String heading,
    String detail,
  ) {
    return showDialog<dynamic>(
      builder: (BuildContext context) {
        return AlertDialog(
          icon: Icon(
            icon,
            size: 50,
          ),
          title: Text(heading),
          content: Text(detail),
          contentTextStyle: context.headlineSmall,
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context); 
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
      context: context,
    );
  }
}
