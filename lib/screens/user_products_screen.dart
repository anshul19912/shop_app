import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

import '../providers/products_provider.dart';

class UserProductScreen extends StatelessWidget {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("You Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/edit-product-screen');
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => _refreshProducts(context),
                child: Consumer<Products>(
                  builder: (ctx, productsData, _) => Padding(
                    padding: EdgeInsets.all(8),
                    child: ListView.builder(
                        itemCount: productsData.items.length,
                        itemBuilder: (_, i) => Column(
                              children: [
                                UserProductItem(
                                    id: productsData.items[i].id!,
                                    title: productsData.items[i].title!,
                                    imageUrl: productsData.items[i].imageUrl!),
                                Divider(),
                              ],
                            )),
                  ),
                ),
              ),
      ),
    );
  }
}
