import 'package:flutter/material.dart';

push(context, Widget screen) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

popPush(context, Widget screen) {
  Navigator.of(context).pop();
  return push(context, screen);
}

resetTo(context, Widget screen) {
  return Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => screen),
    (_) => false,
  );
}