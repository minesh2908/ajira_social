import 'package:ajira_social/views/screens/home/home_screen.dart';
import 'package:ajira_social/views/screens/post/my_post_screen.dart';
import 'package:ajira_social/views/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

final _screens = [
  const MyHomeScreen(),
  const MyPostScreen(),
  const MyProfileScreen(),
];

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  final _currentIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _currentIndexNotifier,
      builder: (context, value, _) {
        return Scaffold(
          body: _screens[_currentIndexNotifier.value],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _currentIndexNotifier.value,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.add_outlined),
                label: 'Add Post',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_2),
                label: 'Profile',
              ),
            ],
            onDestinationSelected: (index) {
              _currentIndexNotifier.value = index;
            },
          ),
        );
      },
    );
  }
}
