//https://github.com/gothinkster/realworld/tree/master/api

import 'package:realworld/utils/http.dart';

class ProfileService {
  get(String username) async => await http.get('/profiles/$username');

  folow(String username) async =>
      await http.post('/profiles/$username/follow');

  unfollow(String username) async =>
      await http.delete('/profiles/$username/follow');
}
