import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/rating.dart';

class RatingProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Rating> data_Rating = [];
  List<Rating> get dataRating => data_Rating;

  double _averageRating = 0.0;
  int _reviewCount = 0;

  double get averageRating => _averageRating;
  int get reviewCount => _reviewCount;

  Future<void> getdataRatingbyDokter(int id) async {
    isLoading = true;
    notifyListeners();

    final response = await http.get(Uri.parse(
        'http://127.0.0.1:8000/rating/$id'));

    if (response.statusCode == 200) {
      data_Rating = RatingFromJson(response.body);

      // Calculate the average rating and review count
      if (data_Rating.isNotEmpty) {
        double totalRating = data_Rating.fold(0, (sum, item) => sum + item.rating);
        _averageRating = totalRating / data_Rating.length;
        _reviewCount = data_Rating.length;
      } else {
        _averageRating = 0.0;
        _reviewCount = 0;
      }
    } else {
      data_Rating = [];
      _averageRating = 0.0;
      _reviewCount = 0;
    }

    print (_averageRating);
    print (_reviewCount);

    isLoading = false;
    notifyListeners();
  }
}
