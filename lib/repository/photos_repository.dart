import 'dart:convert';

import 'package:ajira_social/common/api_url.dart';
import 'package:ajira_social/modals/photos_modal.dart';
import 'package:http/http.dart' as http;

class PhotosRepository {
  Future<List<PhotosModal?>> getUserPhotos(int? id) async {
    try {
      final response =
          await http.get(Uri.parse('${ApiURL.photosUrl}?albumId=$id'));
      if (response.statusCode == 200) {
        final body = response.body;
        final result = (jsonDecode(body) as List).cast<Map<String, dynamic>>();
        print(result);
        return result.map<PhotosModal>(PhotosModal.fromMap).toList();
      } else {
        throw Exception('here');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
