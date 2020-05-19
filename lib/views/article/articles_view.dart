import 'package:flutter/material.dart';
import 'package:realworld/utils/navigate.dart';

import 'package:realworld/models/article.dart';
import 'package:realworld/views/author/author_view.dart';
import 'package:realworld/views/article/article_detail.dart';
import 'package:realworld/views/article/article_card.dart';

class ArticlesView extends StatelessWidget {
  final List<Article> _items;
  final overlapInjector;
  final String pageKey;

  ArticlesView(this._items, {this.pageKey: "articles", this.overlapInjector});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: PageStorageKey<String>(pageKey),
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        overlapInjector ?? SliverToBoxAdapter(),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ArticleCard(
                onAuthorPressed: () {
                  push(context, AuthorView());
                },
                onCardPressed: () {
                  push(context, ArticleDetail(_items[index]));
                },
                onFavoritePressed: () {
                  print("Favorite Pressed");
                },
                onFavoriteLoading: false,
                article: _items[index],
              );
            },
            childCount: _items.length,
          ),
        )
      ],
    );
  }
}
