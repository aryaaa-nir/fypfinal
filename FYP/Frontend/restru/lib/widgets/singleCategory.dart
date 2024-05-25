// import 'package:flutter/material.dart';
// import '../models/product.dart';
// import '../screens/category.dart';

// class SingleCategory extends StatelessWidget {
//   final Category category;

//   const SingleCategory(this.category);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.of(context).pushNamed(
//             CategoryScreens.routeName,
//             arguments: category.id, // Pass the category object as an argument
//           );
//         },
//         child: Card(
//           color: Theme.of(context).primaryColor,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               category.name,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/category.dart';

class SingleCategory extends StatelessWidget {
  final Category category;

  const SingleCategory(this.category);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            CategoryScreens.routeName,
            arguments: category.id, // Pass the category object as an argument
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color.fromARGB(255, 156, 30, 21),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}