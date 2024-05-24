import 'dart:convert';

import 'package:equatable/equatable.dart';

class PostModal extends Equatable {
  const PostModal({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory PostModal.fromJson(String str) =>
      PostModal.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PostModal.fromMap(Map<String, dynamic> json) => PostModal(
        userId: json['userId'] as int?,
        id: json['id'] as int?,
        title: json['title'] as String?,
        body: json['body'] as String?,
      );
  final int? userId;
  final int? id;
  final String? title;
  final String? body;

  PostModal copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) =>
      PostModal(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [userId, id, title, body];
}
