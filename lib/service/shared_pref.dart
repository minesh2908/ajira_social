import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  AppPref._();

  static SharedPreferences? _pref;

  static Future<void> init() async {
    _pref ??= await SharedPreferences.getInstance();
  }

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

  static dynamic get(AppPrefKey key, dynamic defaultValue) {
    final value = _pref!.get(key.name) ?? defaultValue;
    log('PreferenceKey $key Value: $value');
    return value;
  }

  static Future<bool> remove(AppPrefKey key) async {
    return _pref!.remove(key.name);
  }

  static Future<bool> clear() async {
    return _pref!.clear();
  }
}

enum AppPrefKey {
  themeMode('theme_mode'),
  album('album'),
  post('post'),
  profile('profile');

  const AppPrefKey(this.name);

  final String name;
}

class AppPrefHelper {
  static Future<bool> setAlbumResponse({required String album}) async {
    return AppPref.save(AppPrefKey.album, album);
  }

  static String getAlbumResponse() {
    final album = AppPref.get(AppPrefKey.album, '') as String;
    return album;
  }

  static Future<bool> setPostResponse({required String post}) async {
    return AppPref.save(AppPrefKey.post, post);
  }

  static String getPostResponse() {
    final post = AppPref.get(AppPrefKey.post, '') as String;
    return post;
  }

  static Future<bool> setProfileResponse({required String profile}) async {
    return AppPref.save(AppPrefKey.profile, profile);
  }

  static String getProfileResponse() {
    final profile = AppPref.get(AppPrefKey.profile, '') as String;
    return profile;
  }

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
