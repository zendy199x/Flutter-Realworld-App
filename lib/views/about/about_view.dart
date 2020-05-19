import 'package:flutter/material.dart';
import 'package:realworld/views/about/about_content.dart';

class AboutView {
  AboutView(BuildContext parentContext, {Function() callback}) {
    showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Conduit',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green))
              ],
            ),
            titlePadding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            content: AboutContent(),
            actions: <Widget>[
              Container(
                  width: 100.0,
                  child: RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text('CLOSE',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ))
            ],
          );
        }).then<void>((value) {
      print(value);
    });
  }
}
