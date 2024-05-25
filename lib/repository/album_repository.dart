import 'dart:convert';

import 'package:ajira_social/common/api_url.dart';
import 'package:ajira_social/modals/album_modal.dart';
import 'package:ajira_social/service/network_utitilty.dart';
import 'package:ajira_social/service/shared_pref.dart';
import 'package:http/http.dart' as http;

/// Repository class for fetching album data.
class AlbumRepository {
  /// Fetches album details from the internet or cache.
  ///
  /// - Returns: A [Future] with a list of [AlbumModal] or null if an error occurs.
  /// - Throws: [Exception] if there is no internet and no cached data, or if the API call fails.
  Future<List<AlbumModal?>> getAlbumDetails() async {
    try {
      List<dynamic>? response;
      final isInternetConnected = await NetworkUtil.isConnected();
      final cachebody = AppPrefHelper.getAlbumResponse();

      if (!isInternetConnected && cachebody.isEmpty) {
        throw Exception('Please turn on internet');
      } else if (!isInternetConnected && cachebody.isNotEmpty) {
        response = jsonDecode(cachebody) as List<dynamic>;
      } else if (isInternetConnected) {
        final result = await http.get(Uri.parse(ApiURL.albumUrl));

        if (result.statusCode == 200) {
          await AppPrefHelper.setAlbumResponse(album: result.body);
          response = jsonDecode(result.body) as List<dynamic>;
        }
      } else {
        throw Exception('Something went wrong');
      }

      return response!
          .map((album) => AlbumModal.fromMap(album as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
