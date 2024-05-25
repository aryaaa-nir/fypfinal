import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restru/screens/home.dart';
import '../models/orders.dart';
import '../state/cartstate.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CartState>(context).oldorder;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
        backgroundColor: Colors.red.shade900,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(
              HomeScreen.routeName,
            );
          },
        ),
      ),
      body: data == null
          ? Center(child: CircularProgressIndicator())
          : data.isEmpty
              ? Center(child: Text('No orders found'))
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, i) {
                    final orderData = data[i];
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email: ${orderData.email ?? 'Email not available'}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Phone: ${orderData.phone ?? 'Phone not available'}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text("Total : \Rs.${orderData.cart.total}"),
                            SizedBox(height: 10),
                            Divider(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}