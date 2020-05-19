import 'package:flutter/material.dart';

class PostForm extends StatefulWidget {
  PostForm({Key key}) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: ListView(
      addAutomaticKeepAlives: true,
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        _textField(hint: "Title"),
        _textField(hint: "Description"),
        _textField(hint: "Body"),
        _textField(hint: "Tags"),
        _submitButton(),
      ],
    ));
  }

  Widget _textField(
      {String hint,
      TextInputType keyboardType: TextInputType.text,
      bool obscureText,
      Function(String) validator,
      Function onSaved}) {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(hintText: hint),
            keyboardType: keyboardType,
            validator: validator,
            onSaved: onSaved));
  }

  Widget _submitButton() {
    return Container(
      child: RaisedButton(
        child: Text("Publish Article", style: TextStyle(color: Colors.white)),
        onPressed: () {},
      ),
    );
  }
}
