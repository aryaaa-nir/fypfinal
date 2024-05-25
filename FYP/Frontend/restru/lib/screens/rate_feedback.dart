import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubmitReviewScreen extends StatefulWidget {
  @override
  _SubmitReviewScreenState createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends State<SubmitReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  String _rating = '';
  String _comment = '';
  String _userId = ''; // Assuming you have the user ID from your auth system

  Future<void> _submitReview() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();

    final url = 'http://10.0.2.2:8000/submit-review/';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user': _userId,
        'rating': double.parse(_rating),
        'comment': _comment,
      }),
    );

    if (response.statusCode == 201) {
      // Successfully submitted
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Review submitted successfully!'),
      ));
    } else {
      // Error occurred
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to submit review.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a rating';
                  }
                  final rating = double.tryParse(value);
                  if (rating == null || rating < 0 || rating > 5) {
                    return 'Please enter a valid rating between 0 and 5';
                  }
                  return null;
                },
                onSaved: (value) {
                  _rating = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Comment'),
                maxLines: 3,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
                onSaved: (value) {
                  _comment = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitReview,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
