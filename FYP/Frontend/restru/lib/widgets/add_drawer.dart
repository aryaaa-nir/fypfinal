import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:restru/screens/home.dart';
import 'package:restru/screens/login.dart';
import 'package:restru/screens/orderhistory.dart';
import 'package:restru/screens/reserved.dart';
import 'package:restru/screens/tables.dart';
import 'package:restru/screens/ordertracking.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  LocalStorage storage = LocalStorage('usertoken');

  void _logoutNow() async {
    await storage.clear();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(LoginScreen.routename);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 130,
            color: Colors.red.shade900,
            child: Center(
              child: Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
            leading: Icon(
              Icons.home,
              color: Colors.red.shade900,
              size: 30,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(TableScreen.routeName);
            },
            leading: Icon(
              Icons.table_bar,
              color: Colors.red.shade900,
              size: 30,
            ),
            title: Text(
              "Tables",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ReservedScreens.routeName);
            },
            leading: Icon(
              Icons.check_circle,
              color: Colors.red.shade900,
              size: 30,
            ),
            title: Text(
              "Reserved Table",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
            leading: Icon(
              Icons.history,
              color: Colors.red.shade900,
              size: 30,
            ),
            title: Text(
              "Order History",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderTracking.routeName);
            },
            leading: Icon(
              Icons.track_changes,
              color: Colors.red.shade900,
              size: 30,
            ),
            title: Text(
              "Order Tracking",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          ListTile(
            onTap: _logoutNow,
            leading: Icon(
              Icons.logout,
              color: Colors.blue.shade900,
              size: 30,
            ),
            title: Text(
              "Log Out",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}