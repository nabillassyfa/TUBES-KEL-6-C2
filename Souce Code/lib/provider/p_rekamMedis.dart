import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/rekamMedis.dart';
import 'p_user.dart'; // Pastikan Anda mengimpor UserProvider

class RekamMedisProvider extends ChangeNotifier {
  bool isLoading = false;
  List<RekamMedis> data_RekamMedis = [];
  List<RekamMedis> get dataRekamMedis => data_RekamMedis;

  Future<void> getdataRekamMedis(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    int? userId = await userProvider.getUserId();

    print(userId);
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse('http://127.0.0.1:8000/rekam_medis/$userId/'));

    if (response.statusCode == 200) {
      data_RekamMedis = RekamMedisFromJson(response.body);
    } else {
      // Handle error
      print('Failed to load data: ${response.statusCode}');
    }

    isLoading = false;
    notifyListeners();
  }
}
