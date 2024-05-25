// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:restru/state/ordertrackingstate.dart';
// import 'package:restru/models/Ordertrack.dart';
// import '../widgets/add_drawer.dart';

// class OrderTracking extends StatelessWidget {
//     static const routeName = '/orderTracking-screen';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Tracking'),
//       ),
//       body: FutureBuilder(
//         future: Provider.of<OrderTrackState>(context, listen: false).fetchOrders(),
//         builder: (ctx, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.error != null) {
//             return Center(child: Text('An error occurred!'));
//           } else {
//             return Consumer<OrderTrackState>(
//               builder: (ctx, orderProvider, _) {
//                 if (orderProvider.orders == null || orderProvider.orders!.isEmpty) {
//                   return Center(child: Text('No orders found.'));
//                 }
//                 return ListView.builder(
//                   itemCount: orderProvider.orders!.length,
//                   itemBuilder: (ctx, i) => ListTile(
//                     title: Text('Order #${orderProvider.orders![i].id}'),
//                     subtitle: Text('Status: ${orderProvider.orders![i].status}'),
//                     trailing: Text('Created at: ${orderProvider.orders![i].createdAt}'),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restru/state/ordertrackingstate.dart';
import 'package:restru/models/Ordertrack.dart';
import '../widgets/add_drawer.dart';


class OrderTracking extends StatelessWidget {
  static const routeName = '/orderTracking-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Order Tracking',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: Provider.of<OrderTrackState>(context, listen: false).fetchOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.red.shade900),
              ),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text(
                'An error occurred!',
                style: TextStyle(fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return Consumer<OrderTrackState>(
              builder: (ctx, orderProvider, _) {
                if (orderProvider.orders == null || orderProvider.orders!.isEmpty) {
                  return Center(
                    child: Text(
                      'No orders found.',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: orderProvider.orders!.length,
                  itemBuilder: (ctx, i) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          'Order #${orderProvider.orders![i].id}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Status: Your order is ${orderProvider.orders![i].status}',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Text(
                          'Created at: ${orderProvider.orders![i].createdAt}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}