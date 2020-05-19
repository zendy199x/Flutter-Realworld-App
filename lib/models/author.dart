//https://github.com/gothinkster/realworld/tree/master/api

class Author {
  final String username;
  final String bio;
  final String image;
  final String following;

  Author({this.username, this.bio, this.image, this.following});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      username: json['username'] as String,
      bio: json['bio'] as String,
      image: json['image'] as String,
      following: json['image'] as String,
    );
  }
}
