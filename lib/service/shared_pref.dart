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
  profileImage('profileImage'),
  themeMode('theme_mode'),
  firstname('firstname'),
  email('email'),
  username('username'),
  phoneNo('phoneNo'),
  website('website'),
  album('album'),
  post('post'),
  profile('profile');

  const AppPrefKey(this.name);

  final String name;
}

class AppPrefHelper {
  static Future<bool> setAlbum({required String album}) async {
    return AppPref.save(AppPrefKey.album, album);
  }

  static String getAlbum() {
    final album = AppPref.get(AppPrefKey.album, '') as String;
    return album;
  }

  static Future<bool> setPost({required String post}) async {
    return AppPref.save(AppPrefKey.post, post);
  }

  static String getPost() {
    final post = AppPref.get(AppPrefKey.post, '') as String;
    return post;
  }

  static Future<bool> setProfile({required String profile}) async {
    return AppPref.save(AppPrefKey.profile, profile);
  }

  static String getProfile() {
    final profile = AppPref.get(AppPrefKey.profile, '') as String;
    return profile;
  }

  static Future<bool> setProfileImage({required String profileImage}) async {
    return AppPref.save(AppPrefKey.profileImage, profileImage);
  }

  static String getProfileImage() {
    final profileImage = AppPref.get(AppPrefKey.profileImage, '') as String;
    return profileImage;
  }

  static Future<bool> setFirstname({required String firstname}) async {
    return AppPref.save(AppPrefKey.firstname, firstname);
  }

  static String getFirstname() {
    final firstname = AppPref.get(AppPrefKey.firstname, '') as String;
    return firstname;
  }

  static Future<bool> setEmail({required String email}) async {
    return AppPref.save(AppPrefKey.email, email);
  }

  static String getEmail() {
    final email = AppPref.get(AppPrefKey.email, '') as String;
    return email;
  }

  static Future<bool> setUsername({required String username}) async {
    return AppPref.save(AppPrefKey.username, username);
  }

  static String getUsername() {
    final username = AppPref.get(AppPrefKey.username, '') as String;
    return username;
  }

  static Future<bool> setPhoneNo({required String phoneNo}) async {
    return AppPref.save(AppPrefKey.phoneNo, phoneNo);
  }

  static String getPhoneNo() {
    final phoneNo = AppPref.get(AppPrefKey.phoneNo, '') as String;
    return phoneNo;
  }

  static Future<bool> setWebsite({required String website}) async {
    return AppPref.save(AppPrefKey.website, website);
  }

  static String getWebsite() {
    final website = AppPref.get(AppPrefKey.website, '') as String;
    return website;
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
