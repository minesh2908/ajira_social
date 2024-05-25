import 'dart:convert';

import 'package:ajira_social/common/api_url.dart';
import 'package:ajira_social/modals/user_modal.dart';
import 'package:ajira_social/service/network_utitilty.dart';
import 'package:ajira_social/service/shared_pref.dart';
import 'package:http/http.dart' as http;

/// Repository class for fetching user data.
class UserRepository {
  /// Fetches user details from the internet or cache.
  ///
  /// - Returns: A [Future] with a [UserModal] or null if an error occurs.
  /// - Throws: [Exception] if there is no internet and no cached data, or if the API call fails.
  Future<UserModal?> getUserDetail() async {
    try {
      List<dynamic>? response;
      final isInternetConnected = await NetworkUtil.isConnected();
      final cachebody = AppPrefHelper.getProfileResponse();

      if (!isInternetConnected && cachebody.isEmpty) {
        throw Exception('Please connect to internet');
      } else if (!isInternetConnected && cachebody.isNotEmpty) {
        response = jsonDecode(cachebody) as List<dynamic>;
      } else if (isInternetConnected) {
        final result = await http.get(Uri.parse(ApiURL.userUrl));
        if (result.statusCode == 200) {
          await AppPrefHelper.setProfileResponse(profile: result.body);
          response = jsonDecode(result.body) as List<dynamic>;
        }
      } else {
        throw Exception('Something went wrong');
      }

      final userResponse = response?.first as Map<String, dynamic>;
      final userModal = UserModal.fromMap(userResponse);

      return userModal;
    } catch (e) {
      throw Exception(e);
    }
  }
}
