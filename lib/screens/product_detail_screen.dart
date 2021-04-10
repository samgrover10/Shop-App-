import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String route = '/product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;
    final product =
        Provider.of<Products>(context, listen: false).findProdById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20,),
          Text('\$${product.price}',style: TextStyle(color:Colors.grey,fontSize: 20),),
          SizedBox(height: 20,),
          Text(product.description,style: TextStyle(color: Colors.grey, ),softWrap: true,)
        ],
      ),
    );
  }
}
