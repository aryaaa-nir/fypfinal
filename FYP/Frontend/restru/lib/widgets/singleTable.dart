// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:restru/screens/reservation.dart';
// import '../screens/tabledetails.dart';
// import '../state/tablestate.dart';

// class SingleTable extends StatelessWidget {
//   final int id;
//   final String tname;
//   final String imagePath;
//   final bool reserve;
//   final int chairs;

//   const SingleTable({
//     super.key,
//      required this.id,
//       required this.tname,
//         required this.imagePath,
//          required this.reserve,
//          required this.chairs,
//          });

// @override
//   Widget build(BuildContext context) {
//     return GridTile(
//       header: GridTileBar(),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.of(context).pushNamed(
//             TableDetailsScreen.routeName,
//              arguments: id,
             
//              );
//         },
//         child: Image.network(
//           "http://10.0.2.2:8000$imagePath", 
//           fit: BoxFit.cover,),
//       ),

//      footer: GridTileBar(
//   backgroundColor: Colors.black54,
//   title: Text(tname),
//   leading: IconButton(
//     onPressed: () {
//       Provider.of<TableState>(context, listen: false).reserveButton(id);
//     },
//     icon: Icon(
//       Icons.book_online_outlined, // Use the outlined icon
//       color: reserve ? Colors.blue : Colors.white, // Set icon color to blue if reserved
//       size: 24, // Adjust the size as needed
//     ),
//   ),
// ),);

//   }}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restru/screens/reservation.dart';
import '../screens/tabledetails.dart';
import '../state/tablestate.dart';


class SingleTable extends StatelessWidget {
  final int id;
  final String tname;
  final String imagePath;
  final bool reserve;
  final int chairs;

  const SingleTable({
    Key? key,
    required this.id,
    required this.tname,
    required this.imagePath,
    required this.reserve,
    required this.chairs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          TableDetailsScreen.routeName,
          arguments: id,
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  "http://10.0.2.2:8000$imagePath",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tname,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$chairs chairs',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<TableState>(context, listen: false).reserveButton(id);
                        },
                        icon: Icon(
                          Icons.book_online_outlined, // Use the outlined icon
                          color: reserve ? Colors.blue[900] : Colors.black, // Set icon color to blue if reserved
                          size: 24, // Adjust the size as needed
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}