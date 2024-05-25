// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:restru/screens/carts.dart';
// import 'package:restru/screens/orderhistory.dart';
// import 'package:restru/state/cartstate.dart';

// class OrderNew extends StatefulWidget {
//   static const routeName = '/order-now-screen';
//   @override
//   _OrderNewState createState() => _OrderNewState();
// }

// class _OrderNewState extends State<OrderNew> {
//   final _form = GlobalKey<FormState>();
//   String _email = '';
//   String _phone = '';

//   void _orderNew() async {
//     var isValid = _form.currentState?.validate();
//     if (!isValid!) {
//       return;
//     }
//     _form.currentState?.save();
//     final cart = Provider.of<CartState>(context, listen: false).cartModel;
//     bool order = await Provider.of<CartState>(context, listen: false)
//         .ordercart(cart!.id, _email, _phone);
//     if (order) {
//       Navigator.of(context).pushNamed(OrderScreen.routeName);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Order Now"),
//         backgroundColor: Colors.red.shade900,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _form,
//             child: Column(
//               children: [
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: "Email",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return "Enter Your Email";
//                     }
//                     return null;
//                   },
//                   onSaved: (v) {
//                     _email = v!;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: "Phone",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return "Enter Your Phone Number";
//                     }
//                     return null;
//                   },
//                   onSaved: (v) {
//                     _phone = v!;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: _orderNew,
//                       child: Text("Order"),
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.red.shade900,
//                         onPrimary: Colors.white,
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context).pushNamed(CartScreens.routeName);
//                       },
//                       child: Text("Edit Cart"),
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.red.shade900,
//                         onPrimary: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restru/screens/carts.dart';
import 'package:restru/screens/orderhistory.dart';
import 'package:restru/state/cartstate.dart';

class OrderNew extends StatefulWidget {
  static const routeName = '/order-now-screen';
  @override
  _OrderNewState createState() => _OrderNewState();
}

class _OrderNewState extends State<OrderNew> {
  final _form = GlobalKey<FormState>();
  String _email = '';
  String _phone = '';

  void _orderNew() async {
    var isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    final cart = Provider.of<CartState>(context, listen: false).cartModel;
    bool order = await Provider.of<CartState>(context, listen: false)
        .ordercart(cart!.id, _email, _phone);
    if (order) {
      Navigator.of(context).pushNamed(OrderScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).cartModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Now"),
        backgroundColor: Colors.red.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Enter Your Email";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _email = v!;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Phone",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Enter Your Phone Number";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _phone = v!;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: cart != null && cart.cartproducts.isNotEmpty
                          ? () {
                              _orderNew();
                            }
                          : null,
                      child: Text("Order"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red.shade900,
                        onPrimary: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartScreens.routeName);
                      },
                      child: Text("Edit Cart"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red.shade900,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
