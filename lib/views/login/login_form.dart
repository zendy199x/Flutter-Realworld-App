import 'package:flutter/material.dart';
import 'package:realworld/views/login/login_bloc.dart';
import 'package:realworld/views/home/home_view.dart';
import 'package:realworld/views/register/register_form.dart';

enum Account { register, login }

class _LoginScreenState extends State<LoginScreen> {
  final LoginBloc loginBloc = LoginBloc();

  @override
  void initState() {
    loginBloc.initState();
    super.initState();
  }

  @override
  void dispose() {
    loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    emailField() {
      return StreamBuilder(
          stream: loginBloc.email,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                    errorText: snapshot.error,
                    errorStyle: TextStyle(fontSize: 0, height: 0)),
                onChanged: loginBloc.changeEmail);
          });
    }

    passwordField() {
      return StreamBuilder(
        stream: loginBloc.password,
        builder: (context, snapshot) {
          return TextField(
              obscureText: true,
              decoration: InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                  errorText: snapshot.error,
                  errorStyle: TextStyle(fontSize: 0, height: 0)),
              onChanged: loginBloc.changePassword);
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
                          child: passwordField()),
                      Container(
                          margin: EdgeInsets.only(left: 40.0, right: 40.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: RaisedButton(
                                color: Colors.green,
                                textColor: Colors.white,
                                child: Text('LOGIN',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  loginBloc.login().then((_) {
                                    Navigator.pop(context, Account.login);
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
                                        Text('Don\'t have an account? ',
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context, Account.register);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterScreen()),
                                            );
                                          },
                                          child: Text("Register",
                                              style: TextStyle(
                                                  color: Colors.green, fontWeight: FontWeight.bold)),
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

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
