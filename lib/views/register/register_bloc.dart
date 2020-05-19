import 'dart:async';

import 'package:realworld/models/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:realworld/services/auth.service.dart';
import 'package:realworld/utils/http.dart';
import 'package:realworld/utils/storage.dart';
import 'package:realworld/views/root/root_bloc.dart';

class RegisterBloc {
  BehaviorSubject<bool> _loading;
  BehaviorSubject<String> _email;
  BehaviorSubject<String> _username;
  BehaviorSubject<String> _password;

  Observable<bool> get loading => _loading.stream;
  Observable<String> get email => _email.stream;
  Observable<String> get username => _username.stream;
  Observable<String> get password => _password.stream;
  Observable<bool> get submitValid =>
      Observable.combineLatest3(email, username, password, (e, u, p) => true);

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changePassword => _password.sink.add;

  void initState() {
    _loading = BehaviorSubject<bool>(seedValue: false);
    _email = BehaviorSubject<String>(seedValue: "");
    _username = BehaviorSubject<String>(seedValue: "");
    _password = BehaviorSubject<String>(seedValue: "");
  }

  void dispose() {
    _loading.close();
    _email.close();
    _username.close();
    _password.close();
  }

  Future<String> validate() {
    if ((_email.value?.isEmpty ?? true) || (_username.value?.isEmpty ?? true) || (_password.value?.isEmpty ?? true)) {
      if (_email.value?.isEmpty ?? true) {
        _email.sink.addError("Email is required");
      }
      if (_username.value?.isEmpty ?? true) {
        _username.sink.addError("Username is required");
      }
      if (_password.value?.isEmpty ?? true) {
        _password.sink.addError("Password is required");
      }
      return Future.error("invalid");
    }

    return Future.value("valid");
  }

  Future<User> send() async {
    _loading.sink.add(true);

    var credentials = {
      "user": {
        "email": _email.value,
        "username": _username.value,
        "password": _password.value,
      }
    };

    try {
      var response = await AuthService.register(credentials);

      final String token = response.data['user']['token'];

      http.dio.options.headers = {'Authorization': 'Token $token'};

      await storage.write(
        key: "token",
        value: token,
      );

      rootBloc.setUser(User.fromJson(response.data['user']));

      rootBloc.setAuthenticated(true);

      _loading.sink.add(false);
      return User.fromJson(response.data['user']);
    } catch (e) {
      print(e);
      if(e.response != null) {
        List.from(e.response.data["errors"].entries).forEach((f) {
          switch (f.key) {
            case "email":
              _email.sink.addError(f.value[0]);
              break;
            case "username":
              _username.sink.addError(f.value[0]);
              break;
            case "password":
              _password.sink.addError(f.value[0]);
              break;
          }
        });
      }
      _loading.sink.add(false);
      throw(e);
    }
  }
}