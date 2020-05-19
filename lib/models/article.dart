//https://github.com/gothinkster/realworld/tree/master/api

import './author.dart';

// Attribute declaration
class Article {
  final String slug;
  final String title;
  final String description;
  final String body;
  final List tags;
  final String createdAt;
  final String updateAt;
  final bool favorited;
  final int favoritesCount;
  final Author author;

// Declares the constructor function
  Article({
    this.slug,
    this.title,
    this.description,
    this.body,
    this.tags,
    this.createdAt,
    this.updateAt,
    this.favorited,
    this.favoritesCount,
    this.author,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      slug: json['slug'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      body: json['body'] as String,
      tags: json['tagList'] as List,
      createdAt: json['createdAt'] as String,
      updateAt: json['updateAt'] as String,
      favorited: json['favorited'] as bool,
      favoritesCount: json['favoritesCount'] as int,
      author: Author.fromJson(json['author']),
    );
  }
}
