# Ajira Social
Sure, I can help you create documentation for your Flutter project. Here’s a structured documentation format that covers various aspects of your project, including setup, architecture, features, and how to use the code.

### Project Documentation for Ajira Social

---

## Project Overview

Ajira Social is a Flutter application designed to manage user interactions through fetching and displaying data related to users, albums, posts, and comments. The app incorporates several innovative features such as theme change, location services, and image fetching/updating from the camera or mobile storage. The application uses the Bloc pattern for state management.

---

## Table of Contents

1. [Getting Started](#getting-started)
2. [Project Structure](#project-structure)
3. [State Management](#state-management)
4. [Theme Management](#theme-management)
5. [API Integration](#api-integration)
6. [Features](#features)
7. [Dependencies](#dependencies)
8. [How to Run](#how-to-run)

---

## Getting Started

To get started with Ajira Social, clone the repository and ensure you have Flutter installed on your machine. Follow the steps below to set up the project:

```bash
git clone https://github.com/your-repo/ajira_social.git
cd ajira_social
flutter pub get
```

Ensure you have the necessary environment setup by following the Flutter installation guide: [Flutter Install](https://flutter.dev/docs/get-started/install)

---

## Project Structure

```
ajira_social/
├── lib/
│   ├── get_it.dart
│   ├── service/
│   │   └── shared_pref.dart
│   ├── theme/
│   │   ├── theme_manager.dart
│   │   └── theme_provider.dart
│   ├── views/
│   │   ├── screens/
│   │   │   ├── dashboard_screen.dart
│   │   │   ├── home/
│   │   │   │   └── bloc/
│   │   │   │       └── album_bloc.dart
│   │   │   ├── post/
│   │   │   │   └── bloc/
│   │   │   │       └── post_bloc.dart
│   │   │   ├── profile/
│   │   │   │   └── bloc/
│   │   │   │       └── user_bloc.dart
│   └── main.dart
└── pubspec.yaml
```

### Description of Key Files and Directories

- **main.dart**: Entry point of the application.
- **get_it.dart**: Service locator for dependency injection.
- **service/shared_pref.dart**: Shared preferences service for local storage.
- **theme/**: Contains theme-related files for managing light and dark themes.
- **views/screens/**: Contains all the UI screens and their respective BLoC implementations.

---

## State Management

The application uses the Bloc pattern for state management. The Bloc instances are provided at the root level of the application using `MultiBlocProvider`.

### Example: UserBloc

```dart
BlocProvider<UserBloc>(
  create: (context) => UserBloc()..add(GetUserDetailsEvent()),
),
```

Events are dispatched to fetch and manage the state of users, albums, and posts.

---

## Theme Management

Themes are managed using the `ThemeProvider` class, which extends `ChangeNotifier`. The current theme mode is fetched and updated using shared preferences.

```dart
ChangeNotifierProvider<ThemeProvider>(
  create: (context) => ThemeProvider()..getTheme(),
),
```

### Example: Applying Theme

```dart
return MaterialApp(
  theme: appTheme(
    context,
    colorScheme: lightColorScheme,
    systemUiOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  darkTheme: appTheme(
    context,
    colorScheme: darkColorScheme,
    systemUiOverlayStyle: SystemUiOverlayStyle.light,
  ),
  themeMode: themeMode,
  home: const MyDashboard(),
);
```

---

## API Integration

APIs are integrated to fetch data for users, albums, posts, and comments. Each BLoC handles the specific API calls and manages the state accordingly.

---

## Features

1. **Theme Change**: Switch between light and dark themes.
2. **Current Location**: Fetches and displays the user's current location.
3. **Image Update**: Allows updating images from the camera or mobile storage.
4. **API Data Fetching**: Retrieves and displays user, album, post, and comment data.

---

## Dependencies

Key dependencies used in the project:

- `flutter_bloc`: State management using Bloc pattern.
- `provider`: State management for the theme provider.
- `shared_preferences`: Local storage for theme preference.
- `flutter`: Flutter SDK for building the application.

Refer to `pubspec.yaml` for the complete list of dependencies.

---

## How to Run

1. Ensure all dependencies are installed:

```bash
flutter pub get
```

2. Run the application:

```bash
flutter run
```

This will launch the app on the connected device or emulator.

---
## Demo Video
[Watch the Demo video](https://www.loom.com/share/d2e511064b1a45f8ae69d531c9a6cace?sid=e54eb7f6-8839-4ebb-b530-40c3202586cd)

