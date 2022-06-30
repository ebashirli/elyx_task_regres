import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiManager {
  final String baseUrl = "https://reqres.in";

  Future<http.Response> getUsers(int page) async {
    final http.Response response = await http
        .get(Uri.parse("$baseUrl/api/users?page=$page"))
        .whenComplete(() => print("complete:"))
        .catchError((onError) {
      print("error:${onError.toString()}");
    });
    return response;
  }

  Future registerLogin({
    required String email,
    required String password,
    bool isLogin = false,
  }) async {
    String inUp = isLogin ? "login" : 'register';
    final http.Response response = await http.post(
      Uri.parse(("$baseUrl/api/$inUp")),
      body: {"email": email, "password": password},
    );

    return json.decode(response.body);
  }

  Future<http.Response> getUser(int id) async {
    final http.Response response =
        await http.get(Uri.parse("$baseUrl/api/users/$id"));
    return response;
  }

  Future<http.Response> updateUser({required int id, required Map data}) async {
    final http.Response response = await http.post(
      Uri.parse("$baseUrl/api/users/$id"),
      body: data,
    );
    return response;
  }
}
