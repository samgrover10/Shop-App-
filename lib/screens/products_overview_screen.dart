import 'package:flutter/material.dart';

import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFav = false;
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Show favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(child: Text('Show all'), value: FilterOptions.All),
            ],
            onSelected: (value) {
              setState(() {
                if (value == FilterOptions.Favorites) {
                  _showFav = true;
                } else if (value == FilterOptions.All) {
                  _showFav = false;
                }
              });
            },
          )
        ],
      ),
      body: ProductsGrid(_showFav),
    );
  }
}
