import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product(
      {@required this.description,
      @required this.id,
      @required this.imageUrl,
      @required this.price,
      this.isFavorite=false,
      @required this.title});

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
