import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:realworld/views/login/login_form.dart';
import 'package:realworld/views/register/register_form.dart';

class RealWorldRoutes {
  static Router router = Router();

  // =====Handler====
  static Handler _loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        LoginScreen(),
  );

  static Handler _registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
        RegisterScreen(),
  );

  // =====Setup Routes===
  static void setupRoutes(Router router) {
    router.define("login", handler: _loginHandler);

    router.define("register", handler: _registerHandler);
  }
}
