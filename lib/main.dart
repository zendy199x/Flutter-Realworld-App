import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:realworld/utils/http.dart';
import 'package:realworld/utils/storage.dart';
import 'package:realworld/views/root/root_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final String token = await storage.read(key: "token");

  if (token != null) http.auth(token);

  runApp(RootView());
}
