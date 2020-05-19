import 'dart:async';

import 'package:realworld/models/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:realworld/services/auth.service.dart';
import 'package:realworld/services/articles.service.dart';
import 'package:realworld/utils/http.dart';
import 'package:realworld/utils/storage.dart';
import 'package:realworld/views/root/root_bloc.dart';

class RegisterBloc {
  BehaviorSubject<bool> _loading;
  BehaviorSubject<String> _title;
  BehaviorSubject<String> _description;
  BehaviorSubject<String> _body;
  BehaviorSubject<String> _tagList;

  Observable<bool> get loading => _loading.stream;
  Observable<String> get title => _title.stream;
  Observable<String> get description => _description.stream;
  Observable<String> get body => _body.stream;
  Observable<String> get tagList => _tagList.stream;
  Observable<bool> get submitValid =>
      Observable.combineLatest4(title, description, body, tagList, (t, d, b, tl) => true);

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeDescription => _description.sink.add;
  Function(String) get changeBody => _body.sink.add;
  Function(String) get changeTagList => _tagList.sink.add;

  void initState() {
    _loading = BehaviorSubject<bool>(seedValue: false);
    _title = BehaviorSubject<String>(seedValue: "");
    _description = BehaviorSubject<String>(seedValue: "");
    _body = BehaviorSubject<String>(seedValue: "");
    _tagList = BehaviorSubject<String>(seedValue: "");
  }

  void dispose() {
    _loading.close();
    _title.close();
    _description.close();
    _body.close();
    _tagList.close();
  }

  Future<String> validate() {
    if ((_title.value?.isEmpty ?? true) || (_description.value?.isEmpty ?? true) || (_body.value?.isEmpty ?? true) || (_tagList.value?.isEmpty ?? true)) {
      if (_title.value?.isEmpty ?? true) {
        _title.sink.addError("Title is required");
      }
      if (_title.value?.isEmpty ?? true) {
        _description.sink.addError("Description is required");
      }
      if (_body.value?.isEmpty ?? true) {
        _body.sink.addError("Body is required");
      }
      if (_tagList.value?.isEmpty ?? true) {
        _tagList.sink.addError("Tag List is required");
      }
      return Future.error("invalid");
    }

    return Future.value("valid");
  }

  Future<User> send() async {
    _loading.sink.add(true);

    var credentials = {
      "article": {
      "title": _title.value,
      "description": _description.value,
      "body": _body.value,
      "tagList": _tagList.value
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
            case "title":
              _title.sink.addError(f.value[0]);
              break;
            case "description":
              _description.sink.addError(f.value[0]);
              break;
            case "body":
              _body.sink.addError(f.value[0]);
              break;
            case "tagList":
              _tagList.sink.addError(f.value[0]);
              break;
          }
        });
      }
      _loading.sink.add(false);
      throw(e);
    }
  }
}