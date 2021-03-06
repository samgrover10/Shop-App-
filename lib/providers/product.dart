import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;
  String _token;
  String _userId;

  void update(String token, String userId) {
    _token = token;
    _userId = userId;
  }

  Product(
      {@required this.description,
      @required this.id,
      @required this.imageUrl,
      @required this.price,
      this.isFavorite = false,
      @required this.title});

  Future<void> toggleFavorite() async {
    final url = Uri.parse(
        'https://shop-app-ddaa0-default-rtdb.firebaseio.com/userFavorites/$_userId/$id.json?auth=$_token');
    var favStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final response =
        await http.put(url, body: json.encode(isFavorite));
    print(response.statusCode);
    if (response.statusCode >= 400) {
      print(response.statusCode);
      isFavorite = favStatus;
      notifyListeners();
      throw HttpException('Some error occured!');
    }
    favStatus = null;
  }
}
