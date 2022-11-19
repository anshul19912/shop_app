import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  late final String? id;
  late final String? title;
  late final String? description;
  late final double? price;
  late final String? imageUrl;
  
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite =
        !isFavorite; // if it's fav then it will set this as unfav and vice-versa
    notifyListeners(); // it is like setstate i.e if somethng changes then it will rebuild
    final url = Uri.parse(
        'https://project-1-872bb-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token');
    try {
      final response = await http.put(url, body: json.encode(isFavorite));
      if (response.statusCode >= 400) {
        // if we have a ntw error then this will get execute.
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
