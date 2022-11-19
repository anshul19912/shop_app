//futurebuilder here is the alternative of initstate which weare using in productsoverviewscreen.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../providers/orders.dart';

class OrderScreen extends StatelessWidget {
  // var _isLoading = false;

  // @override
  // void initState() {
  //   _isLoading = true;

  //   Provider.of<Orders>(context, listen: false)
  //       .fetchAndSetOrders()
  //       .then((_) => setState(() {
  //             _isLoading = false;
  //           }));

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Your Orders")),
        drawer: AppDrawer(),
        body: FutureBuilder(
          builder: (context, datasnapshot) {
            if (datasnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, i) =>
                        OrderItemWidget(order: orderData.orders[i])),
              );
            }
          },
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        ));
  }
}

//we are using consumer here bcoz when the fetching is done(line 50) it will notify listener then it will listen before scaffold hence whole widget will rebuilt. and this will continue hence we will be seeing loading spinner