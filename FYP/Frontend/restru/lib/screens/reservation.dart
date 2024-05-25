// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:restru/screens/carts.dart';
// import 'package:restru/screens/orderhistory.dart';
// import 'package:restru/screens/tables.dart';
// import 'package:restru/state/cartstate.dart';
// import '../state/tablestate.dart';

// class Reservation extends StatefulWidget {
//   static const routeName = '/reserve-screen';
//   @override
//   _ReservationState createState() => _ReservationState();
// }

// class _ReservationState extends State<Reservation> {
//   final _form = GlobalKey<FormState>();
//   String _email = '';
//   String _phone = '';
//   DateTime _date = DateTime.now();
//   TimeOfDay _time = TimeOfDay.now();

//   void _orderNew() async {
//     if (_form.currentState?.validate() ?? false) {
//       _form.currentState?.save();
//       final tableState = Provider.of<TableState>(context, listen: false);
//       final cart = tableState.tableModel;

//       if (cart != null) {
//         bool order = await tableState.reserveresponse(cart.id, _email, _phone, _date, _time);
//         if (order) {
//           Navigator.of(context).pushNamed(TableScreen.routeName);
//         }
//       } else {
//         // Handle the case where cart is null
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('No table selected')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cart = Provider.of<CartState>(context).cartModel;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Order Now"),
//         backgroundColor: Colors.red.shade900,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _form,
//             child: Column(
//               children: [
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: "Email",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (v) {
//                     if (v == null || v.isEmpty) {
//                       return "Enter Your Email";
//                     }
//                     return null;
//                   },
//                   onSaved: (v) {
//                     _email = v!;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: "Phone",
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (v) {
//                     if (v == null || v.isEmpty) {
//                       return "Enter Your Phone Number";
//                     }
//                     return null;
//                   },
//                   onSaved: (v) {
//                     _phone = v!;
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Date"),
//                           SizedBox(height: 10),
//                           InkWell(
//                             onTap: () async {
//                               final DateTime? pickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: _date,
//                                 firstDate: DateTime.now(),
//                                 lastDate: DateTime(DateTime.now().year + 1),
//                               );
//                               if (pickedDate != null) {
//                                 setState(() {
//                                   _date = pickedDate;
//                                 });
//                               }
//                             },
//                             child: InputDecorator(
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Text(_date.toString().split(" ")[0]),
//                                   Icon(Icons.calendar_today),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 20),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Time"),
//                           SizedBox(height: 10),
//                           InkWell(
//                             onTap: () async {
//                               final TimeOfDay? pickedTime = await showTimePicker(
//                                 context: context,
//                                 initialTime: _time,
//                               );
//                               if (pickedTime != null) {
//                                 setState(() {
//                                   _time = pickedTime;
//                                 });
//                               }
//                             },
//                             child: InputDecorator(
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Text(_time.format(context)),
//                                   Icon(Icons.access_time),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(                     
//                   onPressed: Provider.of<TableState>(context, listen: false).reserveButton(id);
//                   // _orderNew,
//                   child: Text("Order"),
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.red.shade900,
//                     onPrimary: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/tablestate.dart';
import 'tables.dart';

class Reservation extends StatefulWidget {
  static const routeName = '/reserve-screen';

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  final _form = GlobalKey<FormState>();
  String _email = '';
  String _phone = '';
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  String _tableName = '';

  void _orderNew() async {
    if (_form.currentState?.validate() ?? false) {
      _form.currentState?.save();
      final tableState = Provider.of<TableState>(context, listen: false);
      final table = tableState.tableModel;

      if (table != null) {
        final response = await tableState.reserveresponse(
          table.tname,
          _email,
          _phone,
          _date,
          _time,
        );

        if (response) {
          Navigator.of(context).pushNamed(TableScreen.routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Reservation failed. Please try again.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No table selected')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tableState = Provider.of<TableState>(context);
    final table = tableState.tableModel;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Now"),
        backgroundColor: Colors.red.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                if (table != null) ...[
                  TextFormField(
                    initialValue: table.tname,
                    decoration: InputDecoration(
                      labelText: "Table Name",
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onSaved: (v) {
                      _tableName = v!;
                    },
                  ),
                  SizedBox(height: 20),
                ],
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Enter Your Email";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _email = v!;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Phone",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Enter Your Phone Number";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _phone = v!;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date"),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _date,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 1),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  _date = pickedDate;
                                });
                              }
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              child: Row(
                                children: [
                                  Text(_date.toString().split(" ")[0]),
                                  Icon(Icons.calendar_today),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Time"),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () async {
                              final TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: _time,
                              );
                              if (pickedTime != null) {
                                setState(() {
                                  _time = pickedTime;
                                });
                              }
                            },
                            child: InputDecorator(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              child: Row(
                                children: [
                                  Text(_time.format(context)),
                                  Icon(Icons.access_time),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _orderNew,
                  child: Text("Order"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade900,
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
