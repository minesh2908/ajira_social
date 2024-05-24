import 'dart:io';

import 'package:ajira_social/common/constants.dart';
import 'package:ajira_social/theme/theme_manager.dart';
import 'package:ajira_social/theme/theme_provider.dart';
import 'package:ajira_social/views/components/body_widget.dart';
import 'package:ajira_social/views/components/profile_tile.dart';
import 'package:ajira_social/views/screens/profile/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, userState) {
        if (userState.status == UserStatus.failure ||
            userState.status == UserStatus.failure) {
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
          isLoading: userState.status == UserStatus.loading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              centerTitle: true,
              actions: [
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, _) {
                    return Padding(
                      padding: horizontalPadding12,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet<dynamic>(
                            context: context,
                            builder: (context) {
                              return ListView(
                                shrinkWrap: true,
                                children: [
                                  verticalMargin16,
                                  Center(
                                    child: Text(
                                      'Display Theme',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      ListTile(
                                        title: const Text('Light Theme'),
                                        trailing: themeProvider.themeMode ==
                                                ThemeMode.light
                                            ? const Icon(Icons.check)
                                            : const SizedBox.shrink(),
                                        onTap: () {
                                          themeProvider
                                              .changeTheme(ThemeMode.light);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('Dark Theme'),
                                        trailing: themeProvider.themeMode ==
                                                ThemeMode.dark
                                            ? const Icon(Icons.check)
                                            : const SizedBox.shrink(),
                                        onTap: () {
                                          themeProvider
                                              .changeTheme(ThemeMode.dark);
                                        },
                                      ),
                                      ListTile(
                                        title: const Text('System Theme'),
                                        trailing: themeProvider.themeMode ==
                                                ThemeMode.system
                                            ? const Icon(Icons.check)
                                            : const SizedBox.shrink(),
                                        onTap: () {
                                          themeProvider
                                              .changeTheme(ThemeMode.system);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(
                          (themeProvider.themeMode == ThemeMode.system)
                              ? Icons.sync
                              : themeProvider.themeMode == ThemeMode.dark
                                  ? Icons.light_mode
                                  : Icons.dark_mode,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: Padding(
              padding: horizontalPadding12,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text(
                        userState.userModal?.name! ?? '',
                        style: context.titleMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '@${userState.userModal?.username!}',
                        style: context.titleMedium,
                      ),
                      trailing: userState.userModal?.image != null
                          ? Image.file(
                              width: 50,
                              height: 50,
                              File(
                                userState.userModal!.image!.path,
                              ), // Convert XFile to File
                            )
                          : CircleAvatar(
                              radius: 30,
                              child: Text(
                                userState.userModal?.name!.substring(0, 1) ??
                                    '',
                                style: context.headlineMedium,
                              ),
                            ),
                    ),
                    verticalMargin12,
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            indent: 12,
                            endIndent: 12,
                          ),
                        ),
                        Text(
                          'CONTACT',
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
                    verticalMargin16,
                    ProfileTile(
                      iconData: Icons.phone,
                      name: userState.userModal?.phone! ?? '',
                    ),
                    verticalMargin16,
                    ProfileTile(
                      iconData: Icons.web,
                      name: userState.userModal?.website! ?? '',
                    ),
                    verticalMargin16,
                    ProfileTile(
                      iconData: Icons.location_on,
                      name:
                          '${userState.userModal?.address!.street}, ${userState.userModal?.address!.city} ' ??
                              '',
                    ),
                    verticalMargin12,
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            indent: 12,
                            endIndent: 12,
                          ),
                        ),
                        Text(
                          'COMPANY',
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
                    verticalMargin16,
                    ProfileTile(
                      iconData: Icons.apartment,
                      name: userState.userModal!.company!.name ?? '',
                    ),
                    verticalMargin16,
                    ProfileTile(
                      iconData: Icons.campaign,
                      name: userState.userModal!.company!.catchPhrase ?? '',
                    ),
                    verticalMargin16,
                    ProfileTile(
                      iconData: Icons.description,
                      name: userState.userModal!.company!.catchPhrase ?? '',
                    ),
                    verticalMargin16,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
