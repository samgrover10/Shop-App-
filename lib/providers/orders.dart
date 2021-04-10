import 'package:shop_app/providers/cart.dart';

import 'package:flutter/material.dart';

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

  void addOrder(double total, List<CartItem> cartItems) {
    _orders.insert(
        0,
        Order(
            id: DateTime.now().toString(),
            orderProducts: cartItems,
            time: DateTime.now(),
            total: total));
  }
}
