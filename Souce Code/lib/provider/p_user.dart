import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  final String baseUrl = 'http://127.0.0.1:8000';
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<Map<String, dynamic>> signUp(String nama, String username, String email, String password, String noTelp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Signup/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nama': nama,
        'username': username,
        'email': email,
        'password': password,
        'no_telp': noTelp,
      }),
    );

    if (response.statusCode == 200) {
      // _isLoggedIn = true;
      notifyListeners();
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      _isLoggedIn = true;
      notifyListeners();
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
