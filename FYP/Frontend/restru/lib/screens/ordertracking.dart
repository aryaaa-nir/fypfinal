import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restru/state/ordertrackingstate.dart';
import 'package:restru/models/Ordertrack.dart';
import '../widgets/add_drawer.dart';

class OrderTracking extends StatefulWidget {
  static const routeName = '/orderTracking-screen';

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  @override
  Widget build(BuildContext context) {
    // final id = ModalRoute.of(context)?.settings.arguments;
    final track = Provider.of<OrderTrackingState>(context).trackModel;

    // if (id == null) {
    //   // Handle the case where id is null
    //   return Scaffold(
    //     body: Center(
    //       child: Text('No order ID provided.'),
    //     ),
    //   );
    // }

    if (track == null) {
      // Handle loading state
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(), // Show loading indicator
        ),
      );
    }else{

        return Scaffold(
          drawer: AppDrawer(),
          appBar: AppBar(
            title: Text("Track Your Orders from here."),
            // backgroundColor: Colors.red.shade900,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Your order is: ${track.status}"),
                    // Text(track?.status),
                    // Add more widgets to display order details
                  ],
                ),
              ],
            ),
          ),
        );

        }
        }
        }