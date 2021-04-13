import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_prod_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/user_prod_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (_, auth, previousProd) {
            print('update in main.dart');
            return previousProd..update(auth.token,auth.userId);
          },
          create: (_) {
            print('creating product provider');
            return Products();
          },
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProxyProvider<Auth,Orders>(create: (_) => Orders(),
        update: (_,auth,previousOrders)=>previousOrders..update(auth.token,auth.userId),),
      ],
      child: Consumer<Auth>(
        builder: (_, auth, __) => MaterialApp(
            title: 'Shop App',
            theme: ThemeData(
                primarySwatch: Colors.purple,
                accentColor: Colors.deepOrange,
                fontFamily: 'Lato'),
            routes: {
              '/': (_) => auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
              ProductDetailsScreen.route: (_) => ProductDetailsScreen(),
              CartScreen.route: (_) => CartScreen(),
              OrdersScreen.route: (_) => OrdersScreen(),
              UserProductScreen.route: (_) => UserProductScreen(),
              EditProdScreen.route: (_) => EditProdScreen()
            }),
      ),
    );
  }
}
