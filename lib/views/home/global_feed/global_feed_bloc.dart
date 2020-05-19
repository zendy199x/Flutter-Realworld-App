import 'dart:async';

import 'package:dio/dio.dart' show Response;
import 'package:realworld/models/article.dart';
import 'package:realworld/services/articles.service.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject, Observable;

class GlobalFeedBloc {
  // controllers
  BehaviorSubject<bool> _loading;
  BehaviorSubject<List<Article>> _items;
  // observables
  Observable<bool> get loading => _loading.stream;
  Observable<List<Article>> get items => _items.stream;

  void init() {
    _loading = BehaviorSubject<bool>();
    _items = BehaviorSubject<List<Article>>(seedValue: []);
  }

  void dispose() {
    _loading.close();
    _items.close();
  }

  Future<bool> fetchAll() async {
    try {
      Response result = await ArticlesService.all();
      print(result.data["articles"]);
      var articles = result.data["articles"]
          .map((article) => Article.fromJson(article))
          .toList();

      _items.sink.add(List<Article>.from(articles));

      return true;
    } catch (e) {
      throw (e);
    }
  }

  fetchByAuthor(String author) async {
    try {
      Response result = await ArticlesService.byAuthor(author);

      var articles = result.data["articles"]
          .map((article) => Article.fromJson(article))
          .toList();

      _items.sink.add(List<Article>.from(articles));

      return result;
    } catch (e) {
      if (e?.response?.statusCode == 404) _items.sink.addError("No records");
      throw (e);
    }
  }

  fetchByTag(String tag) async {
    try {
      Response result = await ArticlesService.byTag(tag);

      var articles = result.data["articles"]
          .map((article) => Article.fromJson(article))
          .toList();

      _items.sink.add(List<Article>.from(articles));

      return result;
    } catch (e) {
      if (e?.response?.statusCode == 404) _items.sink.addError("No records");
      throw (e);
    }
  }

  loadMore() {}

  clear() {}
}