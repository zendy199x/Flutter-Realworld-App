import 'package:dio/dio.dart' show Dio, DioError;
import 'package:realworld/constants/api.dart' show APIURL;

class Http {
  final Dio dio = Dio();

  auth(token) {
    if (token != null)
    http.dio.options.headers = {'Authorization': 'Token $token'};
  }

  //Handling Errors - https://github.com/flutterchina/dio#extends-dio-class
  get(String url) async {
    try {
      return await dio.get('$APIURL/$url');
    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        print(e.message);
      }
      throw e;
    }
  }

  post(String url, {data}) async {
    try {
      return await dio.post("$APIURL/$url", data: data);
    } catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      throw (e);
    }
  }

  put(String url, {data}) async {
    try {
      return await dio.put("$APIURL/$url", data: data);
    } catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      throw (e);
    }
  }

  patch(String url, {data}) async {
    try {
      return await dio.patch("$APIURL/$url", data: data);
    } catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      throw (e);
    }
  }

    delete(String url) async {
    try {
      return await dio.delete("$APIURL/$url");
    } catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      throw (e);
    }
  }
}

final Http http = Http();
