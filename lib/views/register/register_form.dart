import 'package:flutter/material.dart';
import 'package:realworld/utils/navigate.dart';
import 'package:realworld/views/register/register_bloc.dart';
import 'package:realworld/views/home/home_view.dart';
import 'package:realworld/views/login/login_form.dart';

enum Account { register, login }

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterBloc registerBloc = RegisterBloc();

  @override
  void initState() {
    registerBloc.initState();
    super.initState();
  }

  @override
  void dispose() {
    registerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    usernameField() {
      return StreamBuilder(
          stream: registerBloc.username,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                decoration: InputDecoration(
                    hintText: 'Username',
                    border: InputBorder.none,
                    errorText: snapshot.error,
                    errorStyle: TextStyle(fontSize: 0, height: 0)),
                onChanged: registerBloc.changeUsername);
          });
    }

    emailField() {
      return StreamBuilder(
          stream: registerBloc.email,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                    errorText: snapshot.error,
                    errorStyle: TextStyle(fontSize: 0, height: 0)),
                onChanged: registerBloc.changeEmail);
          });
    }

    passwordField() {
      return StreamBuilder(
        stream: registerBloc.password,
        builder: (context, snapshot) {
          return TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                  errorText: snapshot.error,
                  errorStyle: TextStyle(fontSize: 0, height: 0)),
              onChanged: registerBloc.changePassword);
        },
      );
    }

    confirmPasswordField() {
      return StreamBuilder(
        stream: registerBloc.password,
        builder: (context, snapshot) {
          return TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Confirm password',
                  border: InputBorder.none,
                  errorText: snapshot.error,
                  errorStyle: TextStyle(fontSize: 0, height: 0)),
              onChanged: registerBloc.changePassword);
        },
      );
    }

    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(
                              left: 20.0, right: 40.0, bottom: 40.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child:
                                    Image.asset('images/flutter_realworld.png'),
                              )
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              left: 40.0, right: 40.0, bottom: 10.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.grey))),
                          child: emailField()),
                      Container(
                          margin: EdgeInsets.only(
                              left: 40.0, right: 40.0, bottom: 10.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.grey))),
                          child: usernameField()),
                      Container(
                          margin: EdgeInsets.only(
                              left: 40.0, right: 40.0, bottom: 10.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.grey))),
                          child: passwordField()),
                      Container(
                          margin: EdgeInsets.only(
                              left: 40.0, right: 40.0, bottom: 10.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.grey))),
                          child: confirmPasswordField()),
                      Container(
                          margin: EdgeInsets.only(left: 40.0, right: 40.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: RaisedButton(
                                color: Colors.green,
                                textColor: Colors.white,
                                child: Text('REGISTER',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  registerBloc.validate().then((_) {
                                    print("here");
                                    registerBloc.send().then((_) {
                                      push(context, HomeScreen());
                                    });
                                  });
                                },
                              ))
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()),
                                            );
                                          },
                                          child: Text("Back to login",
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        )
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      icon:
                                          Icon(Icons.home, color: Colors.grey),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                        );
                                      })
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
