import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final Order order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(6),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '\$${widget.order.total}',
              ),
              subtitle: Text(
                  DateFormat('dd/MM/yyyy hh:mm').format(widget.order.time)),
              trailing: IconButton(
                icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ),
           if(_isExpanded) Container(
              height:
                  min(widget.order.orderProducts.length * 20.0 + 50.0, 200.0),
                  padding: EdgeInsets.all(15),
              width: double.infinity,
              child: ListView(
                  children: widget.order.orderProducts
                      .map((prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                prod.title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '\$${prod.price} X ${prod.quantity}',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              )
                            ],
                          ))
                      .toList()),
            )
          ],
        ),
      ),
    );
  }
}
