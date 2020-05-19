import 'dart:async';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import 'package:realworld/models/user.dart';
import 'package:realworld/services/auth.service.dart';
import 'package:realworld/utils/http.dart';
import 'package:realworld/utils/storage.dart';
import 'package:realworld/views/root/root_bloc.dart';

class LoginBloc {
  BehaviorSubject<bool> _loading;
  BehaviorSubject<String> _email;
  BehaviorSubject<String> _password;

  Observable<bool> get loading => _loading.stream;
  Observable<String> get email => _email.stream;
  Observable<String> get password => _password.stream;

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  void initState() {
    _loading = BehaviorSubject<bool>(seedValue: false);
    _email = BehaviorSubject<String>(seedValue: "");
    _password = BehaviorSubject<String>(seedValue: "");
  }

  void dispose() {
    _loading.close();
    _email.close();
    _password.close();
  }

  Future<bool> login() async {
    final String validEmail = _email.value;
    final String validPassword = _password.value;

    if (validEmail.isEmpty) {
      _email.sink.addError("");
    }

    if (validPassword.isEmpty) {
      _password.sink.addError("");
    }

    if (validEmail.isNotEmpty && validPassword.isNotEmpty) {
      print("valid");
      _loading.sink.add(true);

      var credentials = {
        "user": {"email": validEmail, "password": validPassword}
      };

      try {
        Response response = await AuthService.login(credentials);

        final String token = response.data['user']['token'];

        http.dio.options.headers = {'Authorization': 'Token $token'};

        await storage.write(key: "token", value: token);

        rootBloc.setUser(User.fromJson(response.data['user']));

        rootBloc.setAuthenticated(true);

        _loading.sink.add(false);
        return true;
      } catch (e) {
        _loading.sink.add(false);
        _email.sink.addError("");
        throw (e);
      }
    }
    return Future.error("");
  }
}
