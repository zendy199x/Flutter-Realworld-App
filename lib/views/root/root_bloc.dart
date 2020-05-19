import 'dart:async';

import 'package:dio/dio.dart';
import 'package:realworld/models/user.dart';
import 'package:realworld/services/auth.service.dart';
import 'package:realworld/utils/storage.dart';
import 'package:rxdart/rxdart.dart';

export 'package:realworld/models/user.dart';

class RootBloc {
  BehaviorSubject<bool> _loading;
  BehaviorSubject<bool> _authenticated;
  BehaviorSubject<User> _user;

  Observable<bool> get loading => _loading.stream;
  ValueObservable<bool> get authenticated => _authenticated.stream;
  ValueObservable<User> get user => _user.stream;

  void initState() {
    _loading = BehaviorSubject<bool>(seedValue: false);
    _authenticated = BehaviorSubject<bool>(seedValue: false);
    _user = BehaviorSubject<User>();
  }

  void dispose() {
    _loading.close();
    _authenticated.close();
    _user.close();
  }

  void setLoading(bool value) {
    _loading.sink.add(value);
  }

  void setAuthenticated(bool value) {
    _authenticated.sink.add(value);
  }

  void setUser(User value) {
    _user.sink.add(value);
  }

  Future<bool> loadUser() async {
    _loading.sink.add(true);

    print("logged");

    try {
      Response response = await AuthService.current();
      print(response.data['user']);
      _user.sink.add(User.fromJson(response.data['user']));
      _authenticated.sink.add(true);
      _loading.sink.add(false);
      return true;
    } catch (e) {
      _loading.sink.add(false);
      _user.sink.addError("Some Error");
      throw (e);
    }
  }

  Future<bool> logout() async {
    _user.sink.add(null);
    await storage.delete(key: "token");
    setAuthenticated(false);
    return true;
  }
}

final RootBloc rootBloc = RootBloc();
