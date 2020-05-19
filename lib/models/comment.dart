//https://github.com/gothinkster/realworld/tree/master/api

import './author.dart';

class Comment {
  final int id;
  final String createdAt;
  final String updateAt;
  final String body;
  final Author author;

  Comment({this.id, this.createdAt, this.updateAt, this.body, this.author});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as int,
      createdAt: json['createdAt'] as String,
      updateAt: json['updateAt'] as String,
      body: json['body'] as String,
      author: Author.fromJson(json['author']),
    );
  }
}
