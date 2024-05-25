
// import 'package:flutter/material.dart';
// import 'package:restru/state/productstate.dart';
// import 'package:restru/widgets/singleProduct.dart';
// import 'package:provider/provider.dart';
// import 'package:restru/models/product.dart';

// class CategoryScreens extends StatefulWidget {
//   static const routeName = '/category-screens';

//   @override
//   _CategoryScreensState createState() => _CategoryScreensState();
// }

// class _CategoryScreensState extends State<CategoryScreens> {
//   @override
//   Widget build(BuildContext context) {
//     final id = ModalRoute.of(context)?.settings.arguments as int?;
//     final product = Provider.of<ProductState>(context).categoryproduct(id as int);

//     return Scaffold(
//       appBar: AppBar(
//         title: product.isEmpty
//             ? Text("No product for This Category")
//             : Text("All product for ${product[0].category.name}"),
//         backgroundColor: Colors.red.shade900,
//         centerTitle: true,
//       ),
//       body: product.isEmpty
//           ? Center(
//               child: Text("No Product"),
//             )
//           : ListView.builder(
//               itemCount: product.length,
//               itemBuilder: (ctx, i) => Container(
//                 height: 200, // Provide a bounded height
//                 child: SingleProduct(
//                   key: UniqueKey(),
//                   product: product[i],
//                   id: product[i].id,
//                   name: product[i].name,
//                   imagePath: product[i].imagePath,
//                 ),
//               ),
//             ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:restru/state/productstate.dart';
import 'package:restru/widgets/singleProduct.dart';
import 'package:provider/provider.dart';
import 'package:restru/models/product.dart';

class CategoryScreens extends StatefulWidget {
  static const routeName = '/category-screens';

  @override
  _CategoryScreensState createState() => _CategoryScreensState();
}

class _CategoryScreensState extends State<CategoryScreens> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int?;
    final product = Provider.of<ProductState>(context).categoryproduct(id as int);

    return Scaffold(
      appBar: AppBar(
        title: product.isEmpty
            ? Text("No product for This Category")
            : Text("All product for ${product[0].category.name}"),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
      ),
      body: product.isEmpty
          ? Center(
              child: Text("No Product"),
            )
          : ListView.builder(
              itemCount: product.length,
              itemBuilder: (ctx, i) => Container(
                height: 200, // Provide a bounded height
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleProduct(
                  key: UniqueKey(),
                  product: product[i],
                  id: product[i].id,
                  name: product[i].name,
                  imagePath: product[i].imagePath,
                ),
              ),
            ),
    );
  }
}