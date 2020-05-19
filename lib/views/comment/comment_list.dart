import 'package:flutter/material.dart';
import 'package:realworld/models/comment.dart';

import 'package:realworld/views/comment/comment_bloc.dart';
import 'package:realworld/views/comment/comment_card.dart';

class CommentList extends StatelessWidget {
  final CommentBloc _commentBloc;

  CommentList(this._commentBloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _commentBloc.items,
      builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
        if (snapshot.hasError) return getEmpty();
        print(snapshot.connectionState);
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return getLoading();
          case ConnectionState.done:
          case ConnectionState.active:
            return snapshot.data.length > 0
                ? getList(snapshot.data)
                : getEmpty();
        }
        return null;
      },
    );
  }

  getList(List<Comment> items) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CommentCard(items[index]);
        },
      ),
    );
  }

  getLoading({double size: 20.0}) {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          margin: EdgeInsets.all(size),
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        ),
      ),
    );
  }

  getEmpty() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 50.0, bottom: 70.0),
        child: Center(
          child: Text(
            "No Comments",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
