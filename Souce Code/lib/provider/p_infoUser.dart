import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/infoUser.dart'; // Sesuaikan path jika diperlukan

class InfoUserProvider with ChangeNotifier {
  List<InfoUser> _dataInfoUser = [];
  bool _isLoading = false;

  List<InfoUser> get dataInfoUser => _dataInfoUser;
  bool get isLoading => _isLoading;

  Future<void> getdataInfoUser() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('user_id');
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/infoUser/$userId'));

    if (response.statusCode == 200) {
      _dataInfoUser = infoUserFromJson(response.body);
    } else {
      print('herupumi');
      // Handle error
    }

    _isLoading = false;
    notifyListeners();
  }
}
