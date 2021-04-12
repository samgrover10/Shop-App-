import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const route = '/cart';
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final scaffold = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount().toStringAsFixed(2)}',
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.title.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart, scaffold: scaffold)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => CartItem(
                prodId: cart.items.keys.toList()[i],
                id: cart.items.values.toList()[i].id,
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity,
                title: cart.items.values.toList()[i].title,
              ),
              itemCount: cart.itemsLength(),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
    @required this.scaffold,
  }) : super(key: key);

  final Cart cart;
  final ScaffoldMessengerState scaffold;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: CircularProgressIndicator(),
            ),
        )
        : TextButton(
            onPressed: (widget.cart.totalAmount() <= 0)
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      await Provider.of<Orders>(context, listen: false)
                          .addOrder(widget.cart.totalAmount(),
                              widget.cart.items.values.toList());
                      widget.cart.clear();
                    } catch (e) {
                      // print(e);
                      widget.scaffold.hideCurrentSnackBar();
                      widget.scaffold.showSnackBar(
                          SnackBar(content: Text('Cannot add order')));
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
            child: Text(
              'Order now',
              style: TextStyle(
                  color: widget.cart.totalAmount() <= 0
                      ? Colors.grey
                      : Theme.of(context).primaryColor),
            ));
  }
}
