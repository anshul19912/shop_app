import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helpers/custom_route.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Menu"),
            automaticallyImplyLeading: false, // will never show back button
          ),

          Divider(), // will show an line
          ListTile(
              leading: Icon(Icons.shop),
              title: Text("Shop"),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.payment),
              title: Text("Orders"),
              onTap: () {
                // Navigator.of(context).pushReplacementNamed('/orders-screen');
                Navigator.of(context).pushReplacement(
                    CustomRoute(builder: (ctx) => OrderScreen()));
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.edit),
              title: Text("Manage Products"),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed('/user-product-screen');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              }),
        ],
      ),
    );
  }
}
