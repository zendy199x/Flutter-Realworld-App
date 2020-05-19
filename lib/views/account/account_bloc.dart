import 'dart:async';

import 'package:dio/dio.dart';
import 'package:realworld/models/user.dart';
import 'package:realworld/services/auth.service.dart';
import 'package:realworld/utils/http.dart';
import 'package:realworld/utils/storage.dart';
import 'package:realworld/views/root/root_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AccountBloc {
  BehaviorSubject<bool> _loading;

  Observable<bool> get loading => _loading.stream;

  void initState() {
    _loading = BehaviorSubject<bool>(seedValue: false);
  }

  void dispose() {
    _loading.close();
  }

  Future<bool> save(data) async {
    _loading.sink.add(true);

    try {
      Response response = await AuthService.update(data);

      final String token = response.data['user']['token'];

      http.dio.options.headers = {'Authorization': 'Token $token'};

      await storage.write(key: "token", value: token);

      rootBloc.setUser(User.fromJson(response.data['user']));

      _loading.sink.add(false);
      return true;
    } catch (e) {
      _loading.sink.add(false);
      throw (e);
    }
  }
}

class AccountModalView {
  String image;
  String username;
  String bio;
  String email;
  String password;

  Map<String, dynamic> toMap() {
    return {
      "user": {
        "image": this.image,
        "username": this.username,
        "bio": this.bio,
        "email": this.email,
        "password": this.password
      }
    };
  }
}

final AccountBloc accountBloc = AccountBloc();
