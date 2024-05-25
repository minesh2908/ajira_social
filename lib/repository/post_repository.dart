import 'dart:convert';

import 'package:ajira_social/common/api_url.dart';
import 'package:ajira_social/modals/post_modal.dart';
import 'package:ajira_social/service/network_utitilty.dart';
import 'package:ajira_social/service/shared_pref.dart';
import 'package:http/http.dart' as http;

/// Repository class for fetching post data.
class PostRepository {
  /// Fetches post details from the internet or cache.
  ///
  /// - Returns: A [Future] with a list of [PostModal] or null, if an error occurs.
  /// - Throws: [Exception] if there is no internet and no cached data, or if the API call fails.
  Future<List<PostModal>?>? getPostDetails() async {
    try {
      List<dynamic>? response;
      final isInternetConnected = await NetworkUtil.isConnected();
      final cachebody = AppPrefHelper.getPostResponse();

      if (!isInternetConnected && cachebody.isEmpty) {
        throw Exception('Please connect to internet');
      } else if (!isInternetConnected && cachebody.isNotEmpty) {
        response = jsonDecode(cachebody) as List<dynamic>;
      } else if (isInternetConnected) {
        final result = await http.get(Uri.parse(ApiURL.postUrl));
        if (result.statusCode == 200) {
          await AppPrefHelper.setPostResponse(post: result.body);
          response = jsonDecode(result.body) as List<dynamic>;
        } else {
          throw Exception('Something went wrong');
        }
      } else {
        throw Exception('Something went wrong');
      }
      return response
          .map((post) => PostModal.fromMap(post as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
