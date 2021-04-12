import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/providers/cart.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Order {
  final String id;
  final double total;
  final DateTime time;
  final List<CartItem> orderProducts;

  Order(
      {@required this.id,
      @required this.orderProducts,
      @required this.time,
      @required this.total});
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> addOrder(double total, List<CartItem> cartItems) async {
    final url = Uri.parse(
        'https://shop-app-ddaa0-default-rtdb.firebaseio.com/orders.json');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'orderItems': cartItems
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'price': e.price,
                    'quantity': e.quantity
                  })
              .toList(),
          'time': timestamp.toIso8601String(),
          'total': total
        }));
    _orders.insert(
        0,
        Order(
            id: json.decode(response.body)['name'],
            orderProducts: cartItems,
            time: timestamp,
            total: total));
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse(
        'https://shop-app-ddaa0-default-rtdb.firebaseio.com/orders.json');
    final response = await http.get(url);
    // print(json.decode(response.body));
    final ordersData = json.decode(response.body) as Map<String, dynamic>;
    if (ordersData == null) return;
    List<Order> loadedOrders = [];
    ordersData.forEach((key, ordData) {
      loadedOrders.add(Order(
          id: key,
          orderProducts: (ordData['orderItems'] as List<dynamic>)
              .map((cartItem) => CartItem(
                  id: cartItem['id'],
                  price: cartItem['price'],
                  quantity: cartItem['quantity'],
                  title: cartItem['title']))
              .toList(),
          time: DateTime.parse(ordData['time']),
          total: ordData['total']));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }
}
