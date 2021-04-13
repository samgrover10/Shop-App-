import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_prod_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Container(
          //   padding: EdgeInsets.all(20),
          //   height: 200,
          //   width: double.infinity,
          //   color: Theme.of(context).accentColor,
          //   child: Text('Shopping',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),),
          //   alignment: Alignment.bottomLeft,
          // ),
          AppBar(
            title: Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
              title: Text(
                'Shop',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
              leading: Icon(Icons.shop)),
          Divider(),
          ListTile(
              title: Text(
                'Orders',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.route),
              leading: Icon(Icons.payment)),
          Divider(),
          ListTile(
              title: Text(
                'User Products',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.route),
              leading: Icon(Icons.edit)),
          Divider(),
          ListTile(
              title: Text(
                'Logout',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<Auth>(context, listen: false).logOut();
              },
              leading: Icon(Icons.exit_to_app)),
        ],
      ),
    );
  }
}
