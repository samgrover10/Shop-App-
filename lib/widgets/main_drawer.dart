import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';

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
          AppBar(title: Text('Hello Friend'),automaticallyImplyLeading: false,),
          Divider(),
          ListTile(title: Text('Shop',style: TextStyle(color: Theme.of(context).primaryColor),),onTap: ()=>Navigator.of(context).pushReplacementNamed('/'),
          leading: Icon(Icons.shop_two_sharp)
          ),
          Divider(),
           ListTile(title: Text('Orders',style: TextStyle(color: Theme.of(context).primaryColor),),
           onTap: ()=>Navigator.of(context).pushReplacementNamed(OrdersScreen.route),
          leading: Icon(Icons.shop_two_sharp)
          ),
        ],
      ),
    );
  }
}
