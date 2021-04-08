import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String id;
  final String title;
  ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
          child: GestureDetector(
            onTap:()=>Navigator.of(context).pushNamed(ProductDetailsScreen.route,arguments: id),
                      child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
             leading: IconButton(
              icon: Icon(Icons.favorite),onPressed: (){}, color: Theme.of(context).accentColor,),
            title: Text(
              title,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
           trailing: IconButton(icon: Icon(Icons.shopping_cart,color: Theme.of(context).accentColor,),onPressed: (){},),
            ),
          ),
    );
  }
}
