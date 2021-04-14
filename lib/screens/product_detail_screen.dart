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
      // appBar: AppBar(
      //   title: Text(product.title),
      // ),
      body:CustomScrollView(slivers: [
        SliverAppBar(
          // floating: true,
          pinned: true,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(title: Text(product.title),background: Hero(
              tag: productId,
                          child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),),
        ),
        SliverList(delegate: SliverChildListDelegate([
          SizedBox(height: 20,),
          Text('\$${product.price}',style: TextStyle(color:Colors.grey,fontSize: 20),textAlign: TextAlign.center,),
          SizedBox(height: 20,),
          Text(product.description,style: TextStyle(color: Colors.grey, ),softWrap: true,textAlign: TextAlign.center,),
          SizedBox(height: 800,)
        ],
     
        ))
      ],)
      
      
    );
  }
}
