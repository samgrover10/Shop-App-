import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;
  ProductsGrid(this.showFav);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final currentProducts =
        showFav ? productsData.favProducts : productsData.items;
    return GridView.builder(
      padding: EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProxyProvider<Auth,Product>(
        create: (_) => Product(
            description: currentProducts[i].description,
            id: currentProducts[i].id,
            imageUrl: currentProducts[i].imageUrl,
            price: currentProducts[i].price,
            title: currentProducts[i].title,
            isFavorite: currentProducts[i].isFavorite),
            update: (_,auth,previousProd)=>previousProd..update(auth.token,auth.userId),
        child: ProductItem(),
      ),
      itemCount: currentProducts.length,
    );
  }
}
