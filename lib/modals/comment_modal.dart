import 'dart:convert';

import 'package:equatable/equatable.dart';

class CommentModal extends Equatable {
  const CommentModal({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  factory CommentModal.fromJson(String str) =>
      CommentModal.fromMap(json.decode(str) as Map<String, dynamic>);

  factory CommentModal.fromMap(Map<String, dynamic> json) => CommentModal(
        postId: json['postId'] as int?,
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        body: json['body'] as String?,
      );
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  CommentModal copyWith({
    int? postId,
    int? id,
    String? name,
    String? email,
    String? body,
  }) =>
      CommentModal(
        postId: postId ?? this.postId,
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        body: body ?? this.body,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'postId': postId,
        'id': id,
        'name': name,
        'email': email,
        'body': body,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [postId, id, name, email, body];
}
