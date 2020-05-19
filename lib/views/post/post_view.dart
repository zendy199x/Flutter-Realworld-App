import 'package:flutter/material.dart';
import 'package:realworld/views/post/post_form.dart';
import "package:realworld/views/home/home_view.dart";

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Articale'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 30.0, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, HomeScreen());
            }),
        actions: [
          IconButton(icon: Icon(Icons.save, size: 30.0), onPressed: () {}),
        ],
      ),
      body: Container(
        child: PostForm(),
      ),
    );
  }
}