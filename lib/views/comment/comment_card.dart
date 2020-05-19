import 'package:flutter/material.dart';
import 'package:realworld/models/comment.dart';
import 'package:realworld/utils/date.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  CommentCard(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage("${comment.author.image}"),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text("${comment.body}"),
                  Text(
                    "${timeago(comment.createdAt)}",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
