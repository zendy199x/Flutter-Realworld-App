import 'package:timeago/timeago.dart' show format;

timeago(date) {
  return format(DateTime.parse("$date"));
}

