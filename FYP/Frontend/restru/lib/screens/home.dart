
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restru/screens/carts.dart';
import 'package:restru/screens/category.dart';
import 'package:restru/screens/payment.dart';
import 'package:restru/screens/profiles.dart';
// import 'package:restru/screens/rate_feedbback.dart';
import 'package:restru/state/cartstate.dart';
import 'package:restru/state/productstate.dart';
import 'package:restru/widgets/add_drawer.dart';
import 'package:restru/widgets/singleProduct.dart';
import 'package:restru/widgets/singlecategory.dart';
import '../state/categorystate.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _init = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      // print("didChangeDependencies called"); // Debugging print
      _loadData();
      _init = false;
    }
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      // print("Loading data..."); // Debugging print
    });

    try {
      await Provider.of<CartState>(context, listen: false).getCartDatas();
      // print("Cart data loaded"); // Debugging print 
      await Provider.of<CartState>(context, listen: false).getoldOrders();
      // print("Old orders loaded"); // Debugging print
      await Provider.of<CategoryState>(context, listen: false).getCategoryData();
      // print("Category data loaded"); // Debugging print
      _isLoading = await Provider.of<ProductState>(context, listen: false).getProducts();
      // print("Products data loaded: $_isLoading"); // Debugging print
    } catch (error) {
      // print("Error loading data: $error"); // Debugging print
      _isLoading = false;
    }

    setState(() {
      _isLoading = false;
      // print("Data loading complete"); // Debugging print
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductState>(context).products;
    final category = Provider.of<CategoryState>(context).category;

    // print("Building HomeScreen: _isLoading=$_isLoading, category=$category"); // Debugging print

    if (_isLoading || category == null) {
      return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Welcome to Restru"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Welcome to Restru"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(CartScreens.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              },
              icon: Icon(Icons.account_circle_rounded),
            )
          ],
          backgroundColor: Colors.red.shade900,
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: category.length,
                itemBuilder: (ctx, i) => SingleCategory(category[i]),
              ),
            ),
            Divider(color: Colors.grey[300]),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 2,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: product.length,
                itemBuilder: (ctx, i) => SingleProduct(
                  product: product[i],
                  id: product[i].id,
                  name: product[i].name,
                  imagePath: product[i].imagePath,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // Navigator.of(context).pushReplacementNamed(Ratefeed.routename);
                    },
                    icon: Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Rate Us',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 100,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.of(context).pushNamed(PaymentScreen.routeName);
                    },
                    icon: Icon(
                      Icons.money,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Pay Online',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add your onPressed function here
                  },
                  child: Text('Call an Employee'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
