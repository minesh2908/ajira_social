import 'dart:convert';

import 'package:ajira_social/common/api_url.dart';
import 'package:ajira_social/modals/album_modal.dart';
import 'package:http/http.dart' as http;

class AlbumRepository {
  Future<List<AlbumModal?>> getAlbumDetails() async {
    try {
      final response = await http.get(Uri.parse(ApiURL.albumUrl));
      if (response.statusCode == 200) {
        final body = response.body;
        final result = (jsonDecode(body) as List).cast<Map<String, dynamic>>();
        return result.map<AlbumModal>(AlbumModal.fromMap).toList();
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
