import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import '../providers/cart.dart';

import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed('/product-detail-screen', arguments: product.id),
            child: Hero(
              tag: product.id!,
              child: FadeInImage(
                placeholder: AssetImage('assets/images/product-placeholder.png'),
                image: NetworkImage(product.imageUrl!),
                fit: BoxFit.cover,
              ),
            )),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.title!,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: () {
              product.toggleFavoriteStatus(authData.token!, authData.userId!);
            },
            icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).accentColor,
          ),
          trailing: IconButton(
              onPressed: () {
                cart.addItem(product.id!, product.price!, product.title!);
                // With scaffold of context, we establish a connection to the nearest scaffold widget. (i.e Scaffold of product_overview)
                ScaffoldMessenger.of(context)
                    .hideCurrentSnackBar(); // this will hide current snackbar is new snackbar comes
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Added Item to Cart"),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: "UNDO",
                    onPressed: () {
                      cart.removeSingleItem(product.id!);
                    },
                  ),
                ));
              },
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
