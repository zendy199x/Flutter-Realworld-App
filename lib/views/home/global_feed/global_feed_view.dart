import 'package:flutter/material.dart';
import 'package:realworld/models/article.dart';
import 'package:realworld/views/article/articles_view.dart';

import 'package:realworld/views/home/global_feed/global_feed_bloc.dart';

class GlobalFeedView extends StatefulWidget {
  @override
  _GlobalFeedViewState createState() => _GlobalFeedViewState();
}

class _GlobalFeedViewState extends State<GlobalFeedView> with AutomaticKeepAliveClientMixin<GlobalFeedView> {

  GlobalFeedBloc _bloc = GlobalFeedBloc();

  @override
  void initState() {
    super.initState();
    _bloc.init();
    _bloc.fetchAll();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: _bloc.fetchAll,
        child: StreamBuilder(
          stream: _bloc.items,
          builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasError) return getEmpty();
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return getLoading();
              case ConnectionState.done:
              case ConnectionState.active:
                return ArticlesView(snapshot.data);
            }
            return null;
          },
        ),
      ),
    );
  }

  getLoading({double size: 20.0}) {
    return Center(
      child: Container(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
        ),
      ),
    );
  }

  getEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text("No Records.", textAlign: TextAlign.center),
        IconButton(
          onPressed: _bloc.fetchAll,
          icon: Icon(
            Icons.refresh,
            size: 30.0,
            color: Colors.black26,
          ),
        )
      ],
    );
  }
}