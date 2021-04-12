import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_prod_screen.dart';

class UserProductItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String prodId;
  UserProductItem(this.prodId, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final snackbar = ScaffoldMessenger.of(context);
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(title),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(EditProdScreen.route, arguments: prodId);
                    }),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () async {
                      try {
                        await Provider.of<Products>(context, listen: false)
                            .deleteProduct(prodId);
                      } catch (e) {
                        // TODO
                        snackbar.showSnackBar(SnackBar(
                            content: Text(
                          'Deleting failed!',
                          textAlign: TextAlign.center,
                        )));
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
