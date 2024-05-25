// import 'package:flutter/material.dart';
// import 'package:localstorage/localstorage.dart';
// import 'package:provider/provider.dart';
// import 'package:restru/screens/carts.dart';
// import 'package:restru/screens/category.dart';
// import 'package:restru/screens/home.dart';
// import 'package:restru/screens/login.dart';
// import 'package:restru/screens/ordertracking.dart';
// import 'package:restru/screens/payment.dart';
// import 'package:restru/screens/orderhistory.dart';
// import 'package:restru/screens/profiles.dart';
// import 'package:restru/screens/registrations.dart';
// import 'package:restru/screens/reservation.dart';
// import 'package:restru/screens/reserved.dart';
// import 'package:restru/screens/tabledetails.dart';
// import 'package:restru/screens/tables.dart';
// import 'package:restru/state/cartstate.dart';
// import 'package:restru/state/ordertrackingstate.dart';
// import 'package:restru/state/productstate.dart';
// import 'package:restru/screens/productdetails.dart';
// import 'package:restru/state/profilestate.dart';
// import 'package:restru/state/ratefeed.dart';
// import 'package:restru/state/tablestate.dart';
// import 'package:restru/state/userstate.dart';
// import 'package:khalti_flutter/khalti_flutter.dart';


// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

//   @override
//   Widget build(BuildContext context) {
//     final storage = LocalStorage('usertoken');

//     return FutureBuilder(
//       future: storage.ready,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return MaterialApp(
//             home: Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           );
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           var token = storage.getItem('token') as String?;
//           print('Token value: $token');

//           if (token == null) {
//             return MultiProvider(
//               providers: [
//                 ChangeNotifierProvider(create: (ctx) => UserState()),
//               ],
//               child: MaterialApp(
//                 debugShowCheckedModeBanner: false,
//                 home: LoginScreen(),
//                 routes: {
//                   HomeScreen.routeName: (ctx) => HomeScreen(),
//                   ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
//                   LoginScreen.routename: (ctx) => LoginScreen(),
//                   RegisterScreen.routename: (ctx) => RegisterScreen(),
//                   TableScreen.routeName: (ctx) => TableScreen(),
//                   TableDetailsScreen.routeName: (ctx) => TableDetailsScreen(),
//                   ReservedScreens.routeName: (ctx) => ReservedScreens(),
//                   CartScreens.routeName: (ctx) => CartScreens(),
//                   OrderScreens.routeName: (ctx) => OrderScreens(),
//                   OrderTracking.routeName: (ctx) => OrderTracking(),
//                   ProfileScreen.routeName: (ctx) => ProfileScreen(token: ''),
//                   PaymentScreen.routeName: (ctx) => PaymentScreen(),

//                 },
//               ),
//             );
//           }

//           return MultiProvider(
//             providers: [
//               ChangeNotifierProvider(create: (ctx) => ProductState()),
//               ChangeNotifierProvider(create: (ctx) => UserState()),
//               ChangeNotifierProvider(create: (ctx) => TableState()),
//               ChangeNotifierProvider(create: (ctx) => CartState()),
//               ChangeNotifierProvider(create: (ctx) => OrderTrackingState()),
//               ChangeNotifierProvider(create: (ctx) => ProfileState()),
//             ],
//             child: MaterialApp(
//               debugShowCheckedModeBanner: false,
//               navigatorKey: navKey,
//               routes: {
//                 HomeScreen.routeName: (ctx) => HomeScreen(),
//                 ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
//                 LoginScreen.routename: (ctx) => LoginScreen(),
//                 RegisterScreen.routename: (ctx) => RegisterScreen(),
//                 TableScreen.routeName: (ctx) => TableScreen(),
//                 TableDetailsScreen.routeName: (ctx) => TableDetailsScreen(),
//                 ReservedScreens.routeName: (ctx) => ReservedScreens(),
//                 CartScreens.routeName: (ctx) => CartScreens(),
//                 OrderScreens.routeName: (ctx) => OrderScreens(),
//                 OrderTracking.routeName: (ctx) => OrderTracking(),
//                 ProfileScreen.routeName: (ctx) => ProfileScreen(token: token ?? ''),
//                 PaymentScreen.routeName: (ctx) => PaymentScreen(),

//               },
//               home: HomeScreen(),
//             ),
//           );
//         }

//         return MaterialApp(
//           home: Scaffold(
//             body: Center(
//               child: Text('Something went wrong!'),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:restru/screens/carts.dart';
import 'package:restru/screens/category.dart';
import 'package:restru/screens/home.dart';
import 'package:restru/screens/login.dart';
import 'package:restru/screens/orderscreen.dart';
import 'package:restru/screens/ordertracking.dart';
import 'package:restru/screens/payment.dart';
import 'package:restru/screens/orderhistory.dart';
import 'package:restru/screens/profiles.dart';
import 'package:restru/screens/rate_feedback.dart';
// import 'package:restru/screens/rate_feedbback.dart';
import 'package:restru/screens/registrations.dart';
import 'package:restru/screens/reservation.dart';
import 'package:restru/screens/reserved.dart';
import 'package:restru/screens/tabledetails.dart';
import 'package:restru/screens/tables.dart';
import 'package:restru/state/cartstate.dart';
import 'package:restru/state/ordertrackingstate.dart';
import 'package:restru/state/productstate.dart';
import 'package:restru/screens/productdetails.dart';
import 'package:restru/state/profilestate.dart';
import 'package:restru/state/ratefeed.dart';
import 'package:restru/state/tablestate.dart';
import 'package:restru/state/userstate.dart';

import 'state/categorystate.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final storage = LocalStorage('usertoken');

    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          var token = storage.getItem('token') as String?;
          print('Token value: $token');

          return CircularProgressIndicator();
        }
        if (storage.getItem('token') == null) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
          );
        }
        var token = storage.getItem('token') as String?;
          print('Token value: $token');
        return KhaltiScope(
          publicKey: 'test_public_key_8318afb56e2d466d9679ea190396b225',
          enabledDebugging: true,
          builder: (context, navigatorKey) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (ctx) => ProductState()),
              ChangeNotifierProvider(create: (ctx) => UserState()),
              ChangeNotifierProvider(create: (ctx) => TableState()),
              ChangeNotifierProvider(create: (ctx) => CartState()),
              ChangeNotifierProvider(create: (ctx) => OrderTrackState()),
              ChangeNotifierProvider(create: (ctx) => ProfileState()),
              ChangeNotifierProvider(create: (ctx) => CategoryState()),
              ChangeNotifierProvider(create: (ctx) => ReviewProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              routes: {
                '/home': (ctx) => HomeScreen(),
                ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
                LoginScreen.routename: (ctx) => LoginScreen(),
                RegisterScreen.routename: (context) => RegisterScreen(),
                TableScreen.routeName: (ctx) => TableScreen(),
                TableDetailsScreen.routeName: (ctx) => TableDetailsScreen(),
                // Reservation.routeName: (ctx) => Reservation(),
                ReservedScreens.routeName: (ctx) => ReservedScreens(),
                CartScreens.routeName: (ctx) => CartScreens(),
                OrderScreen.routeName: (ctx) => OrderScreen(),
                ProfileScreen.routeName: (ctx) => ProfileScreen(token: token ?? ''),
                OrderTracking.routeName: (ctx) => OrderTracking(),
                OrderNew.routeName: (ctx) => OrderNew(),
                PaymentScreen.routeName: (ctx) => PaymentScreen(),
                ReviewScreen.routeName: (ctx) => ReviewScreen(),
                // Profile.routeName:(ctx)=>Profile(),
                CategoryScreens.routeName:(ctx)=>CategoryScreens(),
              },
              home: HomeScreen(),
            ),
          ),
        );
      },
    );
  }
}