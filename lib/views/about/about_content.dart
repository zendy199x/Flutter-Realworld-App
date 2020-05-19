import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutContent extends StatefulWidget {
  AboutContent({Key key}) : super(key: key);

  @override
  _AboutContentState createState() => _AboutContentState();
}

class _AboutContentState extends State<AboutContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('images/flutter_realworld.png'),
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text:
                          'This app is an exemplary project to show how a Medium.com clone (called Conduit) is built using Flutter to connect to any other backend from ',
                      style: TextStyle(color: Colors.grey)),
                  TextSpan(
                    style: TextStyle(color: Colors.green),
                    text: 'https://realworld.io/',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final url = 'https://realworld.io/';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            forceSafariVC: false,
                          );
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                  ),
                ]))),
            Divider(color: Colors.grey),
            Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                    'RealWorld example project have been initialed by Thinkster.io provide a realworld scenario as tutorial to see how any different backend/frontend programming language and/or framework could work out in your project.',
                    style: TextStyle(color: Colors.grey, fontSize: 14.0))),
            Divider(color: Colors.grey),
            Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text:
                          'This example stack has been created by INsanityDesign.com for RealWorld.io and is licensed under MIT. You can checkout at ',
                      style: TextStyle(color: Colors.grey)),
                  TextSpan(
                    style: TextStyle(color: Colors.green),
                    text: 'https://github.com/zendy199x/',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final url = 'https://github.com/zendy199x/';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            forceSafariVC: false,
                          );
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                  ),
                ]))),
          ],
        ));
  }
}
