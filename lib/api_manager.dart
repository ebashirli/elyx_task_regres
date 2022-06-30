import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiManager {
  final String baseUrl = "https://reqres.in";

  Future<http.Response> getUsers(int page) async {
    final http.Response response = await http
        .get(Uri.parse("$baseUrl/api/users?page=$page"))
        .catchError((onError) {});
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

  Future updateUser({required int id, required Map data}) async {
    final http.Response response = await http.put(
      Uri.parse("$baseUrl/api/users/$id"),
      body: data,
    );

    return json.decode(response.body);
  }
}
