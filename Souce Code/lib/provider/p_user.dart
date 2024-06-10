import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp2/models/user.dart';


class UserProvider with ChangeNotifier {
  final String baseUrl = 'http://127.0.0.1:8000';
  bool _isLoggedIn = false;
  bool _isLoading = false;
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
      var responseData = jsonDecode(response.body);
      await _saveUserId(responseData['id']);
      notifyListeners();
      return responseData;
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
      var responseData = jsonDecode(response.body);
      await _saveUserId(responseData['user_id']);
      return responseData;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> updateUserInfo(User user) async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('user_id');

    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/user/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      // await getdataInfoUser();
      print('update sukses');
    } else {
    print('walawe');
      // Handle error
    }

    _isLoading = false;
    notifyListeners();
  }

  void logout() async {
    _isLoggedIn = false;
    await _clearUserId();
    notifyListeners();
  }

  Future<void> _saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  Future<void> _clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }
}
