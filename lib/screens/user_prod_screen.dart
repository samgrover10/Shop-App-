

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_prod_screen.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import 'package:shop_app/widgets/user_prod_item.dart';

class UserProductScreen extends StatelessWidget {
  static const route = '/userProducts';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context,listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your products'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () =>
                    Navigator.of(context).pushNamed(EditProdScreen.route))
          ],
        ),
        drawer: MainDrawer(),
        body: RefreshIndicator(
          onRefresh: ()=>_refreshProducts(context),
          child: ListView.builder(
            itemBuilder: (ctx, i) => UserProductItem(productsData.items[i].id,
                productsData.items[i].title, productsData.items[i].imageUrl),
            itemCount: productsData.items.length,
          ),
        ));
  }
}
