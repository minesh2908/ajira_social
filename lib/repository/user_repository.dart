import 'dart:convert';

import 'package:ajira_social/common/api_url.dart';
import 'package:ajira_social/modals/user_modal.dart';
import 'package:ajira_social/service/network_utitilty.dart';
import 'package:ajira_social/service/shared_pref.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<UserModal?> getUserDetail() async {
    try {
      List<dynamic>? response;
      final isInternetConnected = await NetworkUtil.isConnected();
      final cachebody = AppPrefHelper.getProfileResponse();

      if (!isInternetConnected && cachebody.isEmpty) {
        print(1);
        throw Exception('Please connect to internet');
      } else if (!isInternetConnected && cachebody.isNotEmpty) {
        print(2);
        response = jsonDecode(cachebody) as List<dynamic>;
      } else if (isInternetConnected) {
        print(3);
        final result = await http.get(Uri.parse(ApiURL.userUrl));
        if (result.statusCode == 200) {
          print(4);
          await AppPrefHelper.setProfileResponse(profile: result.body);
          response = jsonDecode(result.body) as List<dynamic>;
        }
      } else {
        print(5);
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
