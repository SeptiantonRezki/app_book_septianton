import 'dart:async';
import 'dart:convert';

import 'package:app_book_septianton/models/user.dart';
import 'package:http/http.dart' as http;

const _url = "http://192.168.56.1:55521/api/v1";
var _headers = {'Content-Type': 'application/json'};
// const _url = "http://208.87.132.73:55521/api/v1";

Future<User?> getUser({required int id}) async {
  User? user;
  try {
    var url = Uri.parse("$_url/user/$id");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData["data"] != null) {
        user = User.fromJson(responseData["data"]);
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return user;
}

Future<List<User>> getUsers() async {
  List<User> users = [];
  try {
    var url = Uri.parse("$_url/user/");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      for (var item in responseData["data"]) {
        users.add(User.fromJson(item));
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return users;
}

Future<User?> addUser({required String name}) async {
  User? user;

  try {
    var url = Uri.parse("$_url/user/");
    final response = await http.post(url,
        headers: _headers,
        body: json.encode({
          "name": name,
        }));
    if (response.statusCode == 201) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData["data"]) {
        user = User.fromJson(responseData["data"]);
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return user;
}

void main(List<String> args) async {
  var users = await getUsers();
  for (var item in users) {
    print(item.name);
  }
  var user = await getUser(id: 5);
  print(user?.id);
  print(user?.name);
}
