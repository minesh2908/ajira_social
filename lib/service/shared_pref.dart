import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A utility class for managing application preferences using SharedPreferences.
class AppPref {
  AppPref._();

  static SharedPreferences? _pref;

  /// Initializes SharedPreferences.
  static Future<void> init() async {
    _pref ??= await SharedPreferences.getInstance();
  }

  /// Saves a preference value to SharedPreferences.
  ///
  /// Returns true if the value is successfully saved, false otherwise.
  static Future<bool> save(AppPrefKey key, dynamic value) async {
    log('PreferenceKey $key, Value: $value, Type: ${value.runtimeType}');

    if (value == null) {
      return false;
    }

    switch (value.runtimeType) {
      case String:
        return _pref!.setString(key.name, value as String);
      case int:
        return _pref!.setInt(key.name, value as int);
      case bool:
        return _pref!.setBool(key.name, value as bool);
      case double:
        return _pref!.setDouble(key.name, value as double);
      case const (List<String>):
        return _pref!.setStringList(key.name, value as List<String>);
    }

    log('PreferenceKey return false');
    return false;
  }

  /// Retrieves a preference value from SharedPreferences.
  ///
  /// Returns the preference value if found, otherwise returns the [defaultValue].
  static dynamic get(AppPrefKey key, dynamic defaultValue) {
    final value = _pref!.get(key.name) ?? defaultValue;
    log('PreferenceKey $key Value: $value');
    return value;
  }

  /// Removes a preference value from SharedPreferences.
  ///
  /// Returns true if the value is successfully removed.
  static Future<bool> remove(AppPrefKey key) async {
    return _pref!.remove(key.name);
  }

  /// Clears all preference values from SharedPreferences.
  ///
  /// Returns true if the SharedPreferences are successfully cleared.
  static Future<bool> clear() async {
    return _pref!.clear();
  }
}

/// Enumeration of application preference keys.
enum AppPrefKey {
  themeMode('theme_mode'),
  album('album'),
  post('post'),
  profile('profile');

  const AppPrefKey(this.name);

  final String name;
}

/// A helper class for managing specific application preferences.
class AppPrefHelper {
  /// Saves album response to SharedPreferences.
  ///
  /// Returns true if the response is successfully saved.
  static Future<bool> setAlbumResponse({required String album}) async {
    return AppPref.save(AppPrefKey.album, album);
  }

  /// Retrieves album response from SharedPreferences.
  static String getAlbumResponse() {
    final album = AppPref.get(AppPrefKey.album, '') as String;
    return album;
  }

  /// Saves post response to SharedPreferences.
  ///
  /// Returns true if the response is successfully saved.
  static Future<bool> setPostResponse({required String post}) async {
    return AppPref.save(AppPrefKey.post, post);
  }

  /// Retrieves post response from SharedPreferences.
  static String getPostResponse() {
    final post = AppPref.get(AppPrefKey.post, '') as String;
    return post;
  }

  /// Saves profile response to SharedPreferences.
  ///
  /// Returns true if the response is successfully saved.
  static Future<bool> setProfileResponse({required String profile}) async {
    return AppPref.save(AppPrefKey.profile, profile);
  }

  /// Retrieves profile response from SharedPreferences.
  static String getProfileResponse() {
    final profile = AppPref.get(AppPrefKey.profile, '') as String;
    return profile;
  }

  /// Saves the theme mode to SharedPreferences.
  ///
  /// Returns the saved [ThemeMode].
  static Future<ThemeMode> setThemeMode({required ThemeMode mode}) async {
    var modeValue = 0;
    if (mode == ThemeMode.system) {
      modeValue = 0;
    }

    if (mode == ThemeMode.light) {
      modeValue = 1;
    }

    if (mode == ThemeMode.dark) {
      modeValue = -1;
    }

    final flag = await AppPref.save(AppPrefKey.themeMode, modeValue);
    log('Set Theme Mode isSaved: $mode $modeValue $flag');
    return mode;
  }

  /// Retrieves the saved theme mode from SharedPreferences.
  static ThemeMode getThemeMode() {
    final mode = AppPref.get(AppPrefKey.themeMode, 0) as int;
    log('Theme State: $mode');

    switch (mode) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case -1:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
