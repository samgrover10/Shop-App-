import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favProducts {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Product findProdById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addProduct(Product product) async {
    Uri url = Uri.parse(
        'https://shop-app-ddaa0-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite
          }));
      final prod = Product(
          description: product.description,
          imageUrl: product.imageUrl,
          price: product.price,
          title: product.title,
          id: json.decode(response.body)['name']);
      _items.add(prod);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'https://shop-app-ddaa0-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return;
      List<Product> loadedProds = [];
      extractedData.forEach((key, value) {
        loadedProds.add(Product(
            description: value['description'],
            id: key,
            imageUrl: value['imageUrl'],
            price: value['price'],
            title: value['title'],
            isFavorite: value['isFavorite']));
      });
      _items = loadedProds;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProduct(Product updatedProduct) async {
    final index = _items.indexWhere((prod) => prod.id == updatedProduct.id);
    if (index >= 0) {
      final url = Uri.parse(
          'https://shop-app-ddaa0-default-rtdb.firebaseio.com/products/${updatedProduct.id}.json');
      await http.patch(url,
          body: json.encode({
            'title': updatedProduct.title,
            'imageUrl': updatedProduct.imageUrl,
            'description': updatedProduct.description,
            'price': updatedProduct.price
          }));
      _items[index] = updatedProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://shop-app-ddaa0-default-rtdb.firebaseio.com/products/$id.json');
    int existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('An error occured in deletion');
    }
    existingProduct = null;
  }
}
