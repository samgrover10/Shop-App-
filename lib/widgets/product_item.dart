import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print('PRODUCT REBUILDS');
    final scaffold = ScaffoldMessenger.of(context);
    final cart = Provider.of<Cart>(context, listen: false);

    final product = Provider.of<Product>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailsScreen.route, arguments: product.id),
          child: Hero(
            tag: product.id,
                      child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (_, prod, __) => IconButton(
              icon: Icon(
                  prod.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () async {
                try {
                  await prod.toggleFavorite();
                } catch (e) {
                  scaffold.hideCurrentSnackBar();
                  scaffold.showSnackBar(
                      SnackBar(content: Text('Cannot change favorite!')));
                }
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Added to cart!'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeProduct(product.id);
                  },
                ),
              ));
              cart.addProduct(product.id, product.price, product.title);
            },
          ),
        ),
      ),
    );
  }
}
