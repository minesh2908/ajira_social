import 'package:ajira_social/get_it.dart';
import 'package:ajira_social/service/shared_pref.dart';
import 'package:ajira_social/theme/theme_manager.dart';
import 'package:ajira_social/theme/theme_provider.dart';
import 'package:ajira_social/views/screens/dashboard_screen.dart';
import 'package:ajira_social/views/screens/home/bloc/album_bloc.dart';
import 'package:ajira_social/views/screens/post/bloc/post_bloc.dart';
import 'package:ajira_social/views/screens/profile/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures widgets binding is initialized
  await setup(); // Setup dependency injection
  await AppPref.init(); // Initialize shared preferences
  runApp(const MyApp()); // Run the main app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc()
            ..add(
              GetUserDetailsEvent(),
            ), // Initialize UserBloc and trigger user details fetch
        ),
        BlocProvider(
          create: (context) => AlbumBloc()
            ..add(
              GetAlbumEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => PostBloc()
            ..add(
              GetPostsByUser(),
            ),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider()..getTheme(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          final themeMode =
              themeProvider.themeMode; // Get the current theme mode
          return MaterialApp(
            debugShowCheckedModeBanner: false, // Disable debug banner
            title: 'Flutter Demo', // App title
            theme: appTheme(
              context,
              colorScheme: lightColorScheme, // Light theme configuration
              systemUiOverlayStyle: SystemUiOverlayStyle
                  .dark, // Dark system UI overlay style for light theme
            ),
            darkTheme: appTheme(
              context,
              colorScheme: darkColorScheme, // Dark theme configuration
              systemUiOverlayStyle: SystemUiOverlayStyle
                  .light, // Light system UI overlay style for dark theme
            ),
            themeMode: themeMode, // Apply the current theme mode
            home:
                const MyDashboard(), // Set the dashboard screen as the home screen
          );
        },
      ),
    );
  }
}
