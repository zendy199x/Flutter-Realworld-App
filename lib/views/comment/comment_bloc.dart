import 'dart:async';

import 'package:dio/dio.dart';
import 'package:realworld/models/comment.dart';
import 'package:realworld/services/comment.service.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject, Observable;

class CommentBloc {
  String _slug;

  // controllers
  BehaviorSubject<bool> _loading;
  BehaviorSubject<bool> _sending;
  BehaviorSubject<List<Comment>> _items;
  BehaviorSubject<String> _comment;

  // observables
  Observable<bool> get loading => _loading.stream;
  Observable<bool> get sending => _sending.stream;
  Observable<String> get comment => _comment.stream;
  Observable<List<Comment>> get items => _items.stream;
  //
  Function(String) get changeComment => _comment.sink.add;
  // services
  final CommentsService _service = CommentsService();

  void init({String slug}) {
    _slug = slug;
    _loading = BehaviorSubject<bool>();
    _sending = BehaviorSubject<bool>();
    _comment = BehaviorSubject<String>();
    _items = BehaviorSubject<List<Comment>>();
  }

  void dispose() {
    _loading.close();
    _sending.close();
    _comment.close();
    _items.close();
  }

  Future<Response<dynamic>> load() async {
    try {
      Response result = await _service.forArticle(_slug);
      print(result.data);
      var comments = result.data["comments"]
          .map((comment) => Comment.fromJson(comment))
          .toList();

      _items.sink.add(List<Comment>.from(comments));

      return Future.value(result);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  loadMore(String slug) {}

  Future<Response<dynamic>> create() async {
    _sending.sink.add(true);

    Map<String, dynamic> body = {
      "comment": {"body": _comment.value}
    };

    try {
      Response result = await _service.create(_slug, body);
      _sending.sink.add(false);
      return Future.value(result);
    } catch (e) {
      _sending.sink.add(false);
      return Future.error(e);
    }
  }

  delete(String slug) {}
}
