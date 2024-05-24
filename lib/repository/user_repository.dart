import 'dart:convert';
import 'dart:developer';

import 'package:ajira_social/common/api_url.dart';
import 'package:ajira_social/modals/user_modal.dart';
import 'package:ajira_social/service/shared_pref.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<UserModal?> getUserDetail() async {
    try {
      final result = await http.get(Uri.parse(ApiURL.userUrl));
      if (result.statusCode == 200) {
        final body = result.body;
        log(body);

        final response = jsonDecode(body) as List<dynamic>;

        final userResponse = response.first as Map<String, dynamic>;
        final userModal = UserModal.fromMap(userResponse);

        await AppPrefHelper.setFirstname(firstname: userModal.name!);
        await AppPrefHelper.setEmail(email: userModal.email!);
        await AppPrefHelper.setUsername(username: userModal.username!);
        await AppPrefHelper.setPhoneNo(phoneNo: userModal.phone!);
        await AppPrefHelper.setWebsite(website: userModal.website!);

        return userModal;
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
