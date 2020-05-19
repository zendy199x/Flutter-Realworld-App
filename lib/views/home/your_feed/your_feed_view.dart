import 'package:flutter/material.dart';

class YourFeedView extends StatefulWidget {
  YourFeedView({Key key}) : super(key: key);

  @override
  _YourFeedViewState createState() => _YourFeedViewState();
}

class _YourFeedViewState extends State<YourFeedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Container(
          child: Text('Your Feed', style: TextStyle(
            fontSize: 25.0, color: Colors.green, fontWeight: FontWeight.w600
          ))
        ),
      ),
    );
  }
}