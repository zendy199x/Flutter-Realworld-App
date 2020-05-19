import 'package:flutter/material.dart';
import 'package:realworld/utils/storage.dart';

import 'package:realworld/views/home/home_view.dart';
import 'package:realworld/views/root/root_bloc.dart';
import 'package:realworld/views/splash/splash_view.dart';

class RootView extends StatefulWidget {
  @override
  _RootViewState createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  void initState() {
    rootBloc.initState();
    authenticate();
    super.initState();
  }

  authenticate() async {
    final String token = await storage.read(key: "token");
    if (token != null) rootBloc.loadUser();
  }

  @override
  void dispose() {
    rootBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          showSemanticsDebugger: false,
          checkerboardOffscreenLayers: false,
          title: 'Conduit',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: SplashScreen(),
          routes: <String, WidgetBuilder>{
            '/HomeScreen': (BuildContext context) => HomeScreen()
          },
        ));
  }
}
