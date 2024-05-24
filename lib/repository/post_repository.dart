import 'dart:convert';

import 'package:ajira_social/common/api_url.dart';
import 'package:ajira_social/modals/post_modal.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<PostModal>?>? getPostDetails() async {
    try {
      final response = await http.get(Uri.parse(ApiURL.postUrl));
      if (response.statusCode == 200) {
        final body = response.body;
        final result = (jsonDecode(body) as List).cast<Map<String, dynamic>>();
        print(result);
        return result.map<PostModal>(PostModal.fromMap).toList();
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
