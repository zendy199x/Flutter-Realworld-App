//https://github.com/gothinkster/realworld/tree/master/api

import 'package:realworld/utils/http.dart';

class ArticlesService {
  static String _limit(count, p) =>
      'limit=$count&offset=${p != null ? p * count : 0}';

  static all({int page, int lim: 50}) async =>
      await http.get('/articles?${_limit(lim, page)}');

  static byTag(String tag, {int page, int lim: 50}) async =>
      await http.get('/articles?tag=$tag&${_limit(lim, page)}');

  static byAuthor(String author, {int page}) async =>
      await http.get('/articles?author=$author&${_limit(5, page)}');

  static feed() async => await http.get('/articles/feed?limit=50&offset=0');

  static get(slug) async => await http.get('/articles/$slug');

  static create(Map<String, dynamic> data) async =>
      await http.post('/articles', data: data);

  static update(String slug, Map<String, dynamic> data) async =>
      await http.put('/articles/$slug', data: data);

  static del(String slug) async => await http.delete('/articles/$slug');

  static favorite(String slug) async =>
      await http.post('/articles/$slug/favorite');

  static favoritedBy(String author, {int page}) async =>
      await http.get('/articles?favorited=$author&${_limit(5, page)}');

  static unfavorite(String slug) async =>
      await http.delete('/articles/$slug/favorite');
}
