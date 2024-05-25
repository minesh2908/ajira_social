import 'dart:convert';

import 'package:ajira_social/common/api_url.dart';
import 'package:ajira_social/modals/photos_modal.dart';
import 'package:http/http.dart' as http;

/// Repository class for fetching user photos.
class PhotosRepository {
  /// Fetches photos for a user by album ID.
  ///
  /// - Parameter id: The album ID to fetch photos for.
  /// - Returns: A [Future] with a list of [PhotosModal] or null if an error occurs.
  /// - Throws: [Exception] if the API call fails.
  Future<List<PhotosModal?>> getUserPhotos(int? id) async {
    try {
      final response =
          await http.get(Uri.parse('${ApiURL.photosUrl}?albumId=$id'));
      if (response.statusCode == 200) {
        final body = response.body;
        final result = (jsonDecode(body) as List).cast<Map<String, dynamic>>();
        return result.map<PhotosModal>(PhotosModal.fromMap).toList();
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
