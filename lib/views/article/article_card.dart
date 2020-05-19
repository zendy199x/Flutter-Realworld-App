import 'package:flutter/material.dart';

import 'package:realworld/models/article.dart';
import 'package:realworld/utils/date.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final Function() onCardPressed;
  final Function() onAuthorPressed;
  final Function() onFavoritePressed;
  final bool onFavoriteLoading;

  ArticleCard({
    this.onCardPressed,
    this.onAuthorPressed,
    this.onFavoritePressed,
    this.onFavoriteLoading,
    this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onCardPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black12,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: onAuthorPressed,
                    borderRadius: BorderRadius.circular(50),
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.grey[700],
                      backgroundImage:
                          NetworkImage("${article.author.image}"),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            child: Text(article.author.username),
                            onTap: onAuthorPressed,
                          ),
                          Text(
                            "${timeago(article.createdAt)}",
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _FavoriteButton(
                    count: article.favoritesCount,
                    favorited: article.favorited,
                    onPressed: onFavoritePressed,
                    loading: onFavoriteLoading,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    article.title,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    article.description,
                    style: TextStyle(fontSize: 12.0, color: Colors.black54),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  final int count;
  final Function onPressed;
  final bool loading;
  final bool favorited;

  _FavoriteButton({
    this.count,
    this.onPressed,
    this.loading,
    this.favorited,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: favorited ? Colors.green : Colors.white,
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: InkWell(
        onTap: !loading ? onPressed : null,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 7.0),
          child: Container(
            height: 20.0,
            child: Row(
              children: <Widget>[
                Container(
                  height: 20.0,
                  width: 20.0,
                  child: loading
                      ? Container(
                          padding: EdgeInsets.all(2.5),
                          child: CircularProgressIndicator(strokeWidth: 2.0),
                        )
                      : Icon(
                          Icons.favorite,
                          size: 20.0,
                          color: favorited ? Colors.white : Colors.green,
                        ),
                ),
                Container(width: 2),
                Text(
                  "$count",
                  style: TextStyle(color: favorited ? Colors.white : Colors.green),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
