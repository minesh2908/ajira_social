import 'dart:convert';

import 'package:ajira_social/common/api_url.dart';
import 'package:ajira_social/modals/comment_modal.dart';
import 'package:http/http.dart' as http;

/// Repository class for fetching comments.
class CommentRepository {
  /// Fetches comments for a specific post by post ID.
  ///
  /// - Parameter id: The post ID to fetch comments for.
  /// - Returns: A [Future] with a list of [CommentModal] or null if an error occurs.
  /// - Throws: [Exception] if the API call fails.
  Future<List<CommentModal>?> getComments(int id) async {
    try {
      final response =
          await http.get(Uri.parse('${ApiURL.commentsUrl}?postId=$id'));
      if (response.statusCode == 200) {
        final body = response.body;
        final result = (jsonDecode(body) as List).cast<Map<String, dynamic>>();
        return result.map<CommentModal>(CommentModal.fromMap).toList();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
