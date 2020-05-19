//https://github.com/gothinkster/realworld/tree/master/api

import 'package:realworld/utils/http.dart';

class TagsService {
  getAll() async => await http.get('/tags');
}
