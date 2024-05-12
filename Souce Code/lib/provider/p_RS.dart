import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/dataRS.dart';

class RSProvider extends ChangeNotifier {
  bool isLoading = false;
  List<RS> data_RS = [];
  List<RS> get dataRS => data_RS;

  Future<void> getdataRS() async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/RS/'));

    data_RS = RSFromJson(response.body);
    isLoading = false;
    notifyListeners();
  }
}
