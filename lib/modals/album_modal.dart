import 'dart:convert';

import 'package:equatable/equatable.dart';

class AlbumModal extends Equatable {
  const AlbumModal({
    this.userId,
    this.id,
    this.title,
  });

  factory AlbumModal.fromJson(String str) =>
      AlbumModal.fromMap(json.decode(str) as Map<String, dynamic>);

  factory AlbumModal.fromMap(Map<String, dynamic> json) => AlbumModal(
        userId: json['userId'] as int?,
        id: json['id'] as int?,
        title: json['title'] as String?,
      );
  final int? userId;
  final int? id;
  final String? title;

  AlbumModal copyWith({
    int? userId,
    int? id,
    String? title,
  }) =>
      AlbumModal(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'id': id,
        'title': title,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [userId, id, title];
}
