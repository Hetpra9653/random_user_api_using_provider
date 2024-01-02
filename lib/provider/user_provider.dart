import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_user_api_using_provider/model/User.dart';

class UserProvider extends ChangeNotifier {
  List<Results> _users = [];

  List<Results> get users => _users;

  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=20'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body.toString());
      final List<dynamic> results = data['results'];
      _users = results.map((e) => Results.fromJson(e)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
