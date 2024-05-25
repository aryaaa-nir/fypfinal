// import 'package:flutter/material.dart';
// import 'package:restru/state/tablestate.dart';
// import 'package:restru/widgets/add_drawer.dart';
// import 'package:restru/widgets/singleTable.dart';
// import 'package:provider/provider.dart';

// class ReservedScreens extends StatelessWidget {
//   static const routeName = '/reserved';
//   @override
//   Widget build(BuildContext context) {
//     final reserve = Provider.of<TableState>(context).reservations;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Reserved Tables"),
//         // backgroundColor: Colors.red.shade900,
//       ),
//       drawer: AppDrawer(),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           childAspectRatio: 3 / 2,
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemCount: reserve.length,
//         itemBuilder: (ctx, i) => SingleTable(
//           id: reserve[i].id,
//           tname: reserve[i].tname,
//           imagePath: reserve[i].imagePath,
//           reserve: reserve[i].reserve,
//           chairs: reserve[i].chairs,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:restru/state/tablestate.dart';
import 'package:restru/widgets/add_drawer.dart';
import 'package:restru/widgets/singleTable.dart';
import 'package:provider/provider.dart';

class ReservedScreens extends StatelessWidget {
  static const routeName = '/reserved';

  @override
  Widget build(BuildContext context) {
    final reserve = Provider.of<TableState>(context).reservations;

    return Scaffold(
      appBar: AppBar(
        title: Text("Reserved Tables"),
        backgroundColor: Colors.red.shade900,
      ),
      drawer: AppDrawer(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3 / 2,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: reserve.length,
        itemBuilder: (ctx, i) => SingleTable(
          id: reserve[i].id,
          tname: reserve[i].tname,
          imagePath: reserve[i].imagePath,
          reserve: reserve[i].reserve,
          chairs: reserve[i].chairs,
          // isReserved: true, // Add this to show the reserved badge
        ),
      ),
    );
  }
}