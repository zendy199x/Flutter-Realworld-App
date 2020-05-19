import 'package:flutter/material.dart';
import 'package:realworld/views/home/home_view.dart';
import 'package:realworld/views/account/account_form.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 30.0, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, HomeScreen());
            }),
        // actions: [
        //   IconButton(icon: Icon(Icons.save, size: 30.0), onPressed: () {}),
        // ],
      ),
      body: Container(
        child: AccountForm(),
      ),
    );
  }
}
