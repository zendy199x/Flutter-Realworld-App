//https://github.com/gothinkster/realworld/tree/master/api

import 'package:realworld/utils/http.dart';

class AuthService {
  static login(data) async => await http.post('/users/login', data: data);

  static register(data) async => await http.post('./users', data: data);

  static current() async => await http.get('./user');

  static update(data) async => await http.put('/user', data: data);
}
