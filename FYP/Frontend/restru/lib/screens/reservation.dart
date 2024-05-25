// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:restru/screens/carts.dart';
// import 'package:restru/screens/orderhistory.dart';
// import 'package:restru/state/cartstate.dart';

// import '../state/tablestate.dart';

// class Reservation extends StatefulWidget {
//   static const routeName = '/order-now-screen';
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
//     var isValid = _form.currentState?.validate();
//     if (!isValid!) {
//       return;
//     }
//     _form.currentState?.save();
//     final cart = Provider.of<TableState>(context, listen: false).cartModel;
//     bool order = await Provider.of<TableState>(context, listen: false)
//         .reserveresponse(cart!.id, _email, _phone, _date, _time);
//     if (order) {
//       Navigator.of(context).pushNamed(OrderScreen.routeName);
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
//                     if (v!.isEmpty) {
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
//                     if (v!.isEmpty) {
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
//                   onPressed: _orderNew,
//                   child: Text("Order"),
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.red.shade900,
//                         onPrimary: Colors.white,)
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }