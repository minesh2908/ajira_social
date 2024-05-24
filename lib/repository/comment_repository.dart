import 'dart:convert';

import 'package:ajira_social/common/api_url.dart';
import 'package:ajira_social/modals/comment_modal.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  Future<List<CommentModal>?> getComments(int id) async {
    try {
      final response =
          await http.get(Uri.parse('${ApiURL.commentsUrl}?postId=$id'));
      if (response.statusCode == 200) {
        final body = response.body;
        final result = (jsonDecode(body) as List).cast<Map<String, dynamic>>();
        print(result);
        return result.map<CommentModal>(CommentModal.fromMap).toList();
      } else {
        throw Exception('here');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
