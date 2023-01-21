import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:notepad_frontend/models/user_models.dart';

import '../../constants.dart';

Future<dynamic> userAuth(String email, String password) async {
  Map body = {
    // "username": "",
    "email": email,
    "password": password
  };
  var url = Uri.parse("$baseUrl/user/auth/login/");
  var res = await http.post(url, body: body);

  print(res.body);
  print(res.statusCode);
  if (res.statusCode == 200) {
    Map json = jsonDecode(res.body);
    String token = json['key'];
    var box = await Hive.openBox(tokenBox);
    box.put("token", token);
    User? user = await getUser(token);
    return user;
  } else {
    Map json = jsonDecode(res.body);
    print(json);
    if (json.containsKey("email")) {
      return json["email"][0];
    }
    if (json.containsKey("password")) {
      return json["password"][0];
    }
    if (json.containsKey("non_field_errors")) {
      return json["non_field_errors"][0];
    }
  }
}

Future<User?> getUser(String token) async {
  var url = Uri.parse("$baseUrl/user/auth/user/");
  var res = await http.get(url, headers: {
    'Authorization': 'Token ${token}',
  });

  if (res.statusCode == 200) {
    var json = jsonDecode(res.body);

    User user = User.fromJson(json);
    user.token = token;
    return user;
  } else {
    return null;
  }
}

Future<void> logOut(String token) async {
  var url = Uri.parse("$baseUrl/user/auth/logout/");
  var res = await http.post(url, headers: {
    'Authorization': 'Token ${token}',
  });
  print(res.body);
}

Future<dynamic> registerUser(
  String email,
  String nickname,
  String password,
  String confirm_password,
) async {
  Map<String, dynamic> data = {
    "email": email,
    "password1": password,
    "password2": confirm_password,
    "nickname": nickname,
  };

  var url = Uri.parse("$baseUrl/user/auth/registration/");
  var res = await http.post(url, body: data);

// {
//     "key": "6d03435fe7d0356e7fbac5f4c35af8a63157548b"
// }

  if (res.statusCode == 200 || res.statusCode == 201) {
    Map json = jsonDecode(res.body);

    if (json.containsKey("key")) {
      String token = json["key"];
      var box = await Hive.openBox(tokenBox);
      box.put("token", token);
      var a = await getUser(token);
      if (a != null) {
        User user = a;
        return user;
      } else {
        return null;
      }
    }
  } else if (res.statusCode == 400) {
    Map json = jsonDecode(res.body);
    if (json.containsKey("email")) {
      return json["email"][0];
    } else if (json.containsKey("password")) {
      return json["password"][0];
    }
  } else {
    print(res.body);
    print(res.statusCode);
    return null;
  }
}




// example1gmail.com
// 1GpTuZ6E