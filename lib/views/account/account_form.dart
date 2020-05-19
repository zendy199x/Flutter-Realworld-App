import 'package:flutter/material.dart';
import 'package:realworld/views/root/root_bloc.dart';
import 'package:realworld/views/account/account_bloc.dart';

class AccountForm extends StatefulWidget {
  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final AccountModalView _accountView = AccountModalView();
  final AccountBloc _accountBloc = AccountBloc();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _accountBloc.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          addAutomaticKeepAlives: true,
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            _textField(
                hint: "URL of profile picture",
                keyboardType: TextInputType.url,
                initialValue: rootBloc.user.value.image ?? "",
                onSaved: (val) => _accountView.image = val),
            _textField(
                hint: "Username",
                keyboardType: TextInputType.text,
                initialValue: rootBloc.user.value.username,
                validator: (val) =>
                    val.isEmpty ? "Username can\'t be empty" : null,
                onSaved: (val) => _accountView.username = val),
            _textField(
                hint: "Short bio about you",
                keyboardType: TextInputType.text,
                initialValue: rootBloc.user.value.bio ?? "",
                maxLines: 3,
                onSaved: (val) => _accountView.bio = val),
            _textField(
                hint: "Email",
                keyboardType: TextInputType.emailAddress,
                initialValue: rootBloc.user.value.email,
                validator: (val) =>
                    val.isEmpty ? "Please type your email" : null,
                onSaved: (val) => _accountView.email = val),
            _textField(
                hint: "New password",
                keyboardType: TextInputType.visiblePassword,
                validator: (val) => val.length < 6
                    ? "Password should be minimum 6 characters"
                    : null,
                onSaved: (val) => _accountView.password = val,
                obscureText: true),
            _textField(
                hint: "Confirm password",
                keyboardType: TextInputType.visiblePassword,
                validator: (val) {
                  if (val.length < 6) {
                    return "Password should be minimum 6 characters";
                  } else if (_accountView.password != null && val != _accountView.password) {
                    return 'Password not matched';
                  }
                  return null;
                },
                obscureText: true),
            _submitButton(onPressed: _onSubmit)
          ],
        ));
  }

  Widget _textField({
    String hint,
    TextInputType keyboardType,
    Function(String) validator,
    Function onSaved,
    String initialValue,
    int maxLines: 1,
    bool obscureText: false,
    bool autocorrect: false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        decoration: InputDecoration(hintText: hint),
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        onSaved: onSaved,
        initialValue: initialValue,
        obscureText: obscureText,
        autocorrect: autocorrect,
      ),
    );
  }

  Widget _submitButton({Function() onPressed}) {
    return Container(
      child: RaisedButton(
        color: Colors.green,
        child: Text("Update Account", style: TextStyle(color: Colors.white)),
        onPressed: onPressed,
      ),
    );
  }

  void _onSubmit() async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      _accountBloc.save(_accountView.toMap()).then((_) async {
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green, content: Text("Account Updated !")));
      }).catchError((err) {
        Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("${err.response.toString()}")));
      });
    }
  }
}
