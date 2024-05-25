// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:restru/screens/payment.dart';
// // import 'package:restru/screens/payment.dart';
// import '../models/cart.dart';
// import '../state/cartstate.dart';
// import '../widgets/add_drawer.dart';
// import 'home.dart';
// import 'orderscreen.dart';

// class CartScreens extends StatelessWidget {
//   static const routeName = '/cart';

//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartState>(context).cartModel;
//     if (cart == null) {
//       return Scaffold(
//         appBar: AppBar(
//            leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.of(context).pushReplacementNamed(
//                                 HomeScreen.routeName);
//             },
//           ),
//           title: Text("No Cart"),
//         ),
//         body: Center(
//           child: Text("No Cart Found"),
//         ),
//       );
//     } else {
//       return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.of(context).pushReplacementNamed(
//                                 HomeScreen.routeName);
//             },
//           ),
//           title: Text("My Cart"),
//           // backgroundColor: Colors.red.shade900,
//           actions: [
//             ElevatedButton.icon(
//               onPressed: null,
//               icon: Icon(
//                 Icons.shopping_cart,
//                 color: Colors.white,
//               ),
//               label: Text(
//                 "${cart?.cartproducts.length}",
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(12),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text("Total: ${cart.total}"),
//                   Text("Date: ${cart.date}"),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.green,
//                     ),
//                     onPressed: cart.cartproducts.length <= 0
//                         ? null
//                         : () {
//                           Navigator.of(context).pushNamed(OrderNew.routeName);
//                           },
//                     child: Text("Order"),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.red,
//                     ),
//                     onPressed: cart.cartproducts.length <= 0
//                         ? null
//                         : () async {
//                             bool isdelete = await Provider.of<CartState>(
//                               context,
//                               listen: false,
//                             ).deletecart(cart.id);
//                             if (isdelete) {
//                               Navigator.of(context).pushReplacementNamed(
//                                 HomeScreen.routeName,
//                               );
//                             }
//                           },
//                     child: Text("Delete"),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: cart.cartproducts.length,
//                   itemBuilder: (ctx, i) {
//                     var item = cart.cartproducts[i];
//                     return Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(item.product[0].name),
//                                 Text("Price : ${item.price}"),
//                                 Text("quantity : ${item.quantity}"),
//                               ],
//                             ),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors.lightGreen,
//                               ),
//                               onPressed: () {
//                                 Provider.of<CartState>(
//                                   context,
//                                   listen: false,
//                                 ).deletecartproduct(item.id);
//                               },
//                               child: Text("Delete"),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restru/screens/payment.dart';
import '../models/cart.dart';
import '../state/cartstate.dart';
import '../widgets/add_drawer.dart';
import 'home.dart';
import 'orderscreen.dart';

class CartScreens extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).cartModel;
    if (cart == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                HomeScreen.routeName,
              );
            },
          ),
          title: Text("No Cart"),
          backgroundColor: Colors.red.shade900,
        ),
        body: Center(
          child: Text("No Cart Found"),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                HomeScreen.routeName,
              );
            },
          ),
          title: Text("My Cart"),
          backgroundColor: Colors.red.shade900,
          actions: [
            ElevatedButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: Text(
                "${cart?.cartproducts.length}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red.shade900,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Total: ${cart.total}"),
                  Text("Date: ${cart.date}"),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: cart.cartproducts.length <= 0
                        ? null
                        : () {
                          Navigator.of(context).pushNamed(OrderNew.routeName);
                          },
                    child: Text("Order"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: cart.cartproducts.length <= 0
                        ? null
                        : () async {
                            bool isdelete = await Provider.of<CartState>(
                              context,
                              listen: false,
                            ).deletecart(cart.id);
                            if (isdelete) {
                              Navigator.of(context).pushReplacementNamed(
                                HomeScreen.routeName,
                              );
                            }
                          },
                    child: Text("Delete"),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cartproducts.length,
                  itemBuilder: (ctx, i) {
                    var item = cart.cartproducts[i];
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product[0].name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("Price : ${item.price}"),
                                Text("quantity : ${item.quantity}"),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightGreen,
                              ),
                              onPressed: () {
                                Provider.of<CartState>(
                                  context,
                                  listen: false,
                                ).deletecartproduct(item.id);
                              },
                              child: Text("Delete"),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}