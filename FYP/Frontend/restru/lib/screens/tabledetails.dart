import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restru/models/table.dart';
import 'package:restru/screens/reservation.dart';
import 'package:restru/screens/reserved.dart';
import 'package:restru/state/tablestate.dart';
import 'package:collection/collection.dart'; // Import the collection package

class TableDetailsScreen extends StatelessWidget {
  static const routeName = '/table-details';

  const TableDetailsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final tableState = Provider.of<TableState>(context);
    
    // Use firstWhereOrNull to find the table, or return null if not found
    final table = tableState.tables.firstWhereOrNull((element) => element.id == id as int);

    if (table == null) {
      // Handle the case where the table with the given id is not found
      return Scaffold(
        appBar: AppBar(
          title: Text("Table Not Found"),
          backgroundColor: Colors.red.shade900,
        ),
        body: Center(
          child: Text("The requested table was not found."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Table Details"),
        backgroundColor: Colors.red.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "http://10.0.2.2:8000${table.imagePath}",
                fit: BoxFit.cover,
                height: 250,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price: \Rs.${table.price}",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(ReservedScreens.routeName);
                  },
                  icon: Icon(
                    Icons.book_online_outlined,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Reserve Table",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade900),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            if (table.chairs != null) // Null check for chairs
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Seats: ${table.chairs}",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 16.0),
            Text(
              table.tableDesc,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}