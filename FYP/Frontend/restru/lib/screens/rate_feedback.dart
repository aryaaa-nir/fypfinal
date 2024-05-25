// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:provider/provider.dart';

// import '../state/ratefeed.dart';

// class ReviewScreen extends StatefulWidget {
//   static const routeName = '/review-screen';

//   @override
//   _ReviewScreenState createState() => _ReviewScreenState();
// }

// class _ReviewScreenState extends State<ReviewScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _comment = '';
//   double? _rating;

//   Future<void> _submitReview() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       final response = await Provider.of<ReviewProvider>(context, listen: false)
//           .postReview(_comment, _rating!);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(response['message'])),
//       );
//       if (response['error'] == false) {
//         _formKey.currentState!.reset();
//         setState(() {
//           _rating = null;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Post a Review'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Comment'),
//                 maxLines: 3,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a comment';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _comment = value!;
//                 },
//               ),
//               SizedBox(height: 20),
//               DropdownButtonFormField<double>(
//                 value: _rating,
//                 decoration: InputDecoration(labelText: 'Rating'),
//                 items: [1, 2, 3, 4, 5]
//                     .map((value) => DropdownMenuItem<double>(
//                           value: value.toDouble(),
//                           child: Text(value.toString()),
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _rating = value;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null || value <= 0) {
//                     return 'Please select a rating';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitReview,
//                 child: Text('Submit Review'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:restru/screens/home.dart';

import '../state/ratefeed.dart';

class ReviewScreen extends StatefulWidget {
  static const routeName = '/review-screen';

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  String _comment = '';
  double? _rating;

  Future<void> _submitReview() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final response = await Provider.of<ReviewProvider>(context, listen: false)
          .postReview(_comment, _rating!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
      if (response['error'] == false) {
        _formKey.currentState!.reset();
        setState(() {
          _rating = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                HomeScreen.routeName,
              );
            },
          ),
        title: Text(
          'Post a Review',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
                onSaved: (value) {
                  _comment = value!;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<double>(
                value: _rating,
                decoration: InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(),
                ),
                items: [1, 2, 3, 4, 5]
                    .map((value) => DropdownMenuItem<double>(
                          value: value.toDouble(),
                          child: Text(value.toString()),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
                validator: (value) {
                  if (value == null || value <= 0) {
                    return 'Please select a rating';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  primary: Colors.red.shade900,
                  onPrimary: Colors.white,
                  elevation: 5,
                ),
                child: Text(
                  'Submit Review',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}