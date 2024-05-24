import 'dart:convert';

import 'package:equatable/equatable.dart';

class PhotosModal extends Equatable {
  const PhotosModal({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory PhotosModal.fromJson(String str) =>
      PhotosModal.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PhotosModal.fromMap(Map<String, dynamic> json) => PhotosModal(
        albumId: json['albumId'] as int?,
        id: json['id'] as int?,
        title: json['title'] as String?,
        url: json['url'] as String?,
        thumbnailUrl: json['thumbnailUrl'] as String?,
      );
  final int? albumId;
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnailUrl;

  PhotosModal copyWith({
    int? albumId,
    int? id,
    String? title,
    String? url,
    String? thumbnailUrl,
  }) =>
      PhotosModal(
        albumId: albumId ?? this.albumId,
        id: id ?? this.id,
        title: title ?? this.title,
        url: url ?? this.url,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'albumId': albumId,
        'id': id,
        'title': title,
        'url': url,
        'thumbnailUrl': thumbnailUrl,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [albumId, id, title, url, thumbnailUrl];
}
