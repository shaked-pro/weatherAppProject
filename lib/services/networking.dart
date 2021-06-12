import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  String url;
  NetworkHelper(this.url);
  Future<String> getdata() async {
    String data;
    Response res = await get(url);
    if (res.statusCode == 200) {
      data = res.body;
    } else {
      print(res.statusCode);
    }
    return data;
  }
}
