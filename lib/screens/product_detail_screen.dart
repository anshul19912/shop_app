import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context,
            listen:
                false) // false means that this widget here will not rebuild if notifyListeners is called
        .items
        .firstWhere((prod) => prod.id == productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title!),
      // ),
      body: CustomScrollView(
        //sliver are the scrollable areas on the screen
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title!),
              background: Hero(
                tag: loadedProduct.id!,
                child: Image.network(
                  loadedProduct.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            Text(
              "Rs. ${loadedProduct.price}",
              style: TextStyle(color: Colors.grey, fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedProduct.description!,
                  textAlign: TextAlign.center,
                  softWrap: true,
                )),
            SizedBox(
              height: 2000,
            )
          ]))
        ],
      ),
    );
  }
}
