import 'dart:convert';

import 'package:api_dummy/models/model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Repository {
  final _baseUrl = 'https://651b06ce340309952f0e2bf7.mockapi.io';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/ucup'));

      if (response.statusCode == 200) {
        // print(response.body);
        Iterable it = jsonDecode(response.body);
        List<User> user = it.map((e) => User.fromJson(e)).toList();

        return user;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future postData(
      String createdAt, String name, String avatar, String id) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl + '/ucup'), body: {
        'createdAt': createdAt,
        'name': name,
        'avatar': avatar,
        'id': id
      });
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future puData(int id, String createdAt, String name, String avatar) async {
    try {
      final response =
          await http.put(Uri.parse(_baseUrl + '/ucup/' + id.toString()), body: {
        'createdAt': createdAt,
        'name': name,
        'avatar': avatar,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.delete(
        Uri.parse(_baseUrl + '/ucup/' + id),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }
}
