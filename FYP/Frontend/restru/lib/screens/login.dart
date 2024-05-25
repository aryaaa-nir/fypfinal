import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restru/screens/home.dart';
import 'package:restru/screens/registrations.dart';
import 'package:restru/state/userstate.dart';

import '../state/productstate.dart';

class LoginScreen extends StatefulWidget {
  static const routename = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = '';
  String _password = '';
  bool _obscureText = true;
  final _form = GlobalKey<FormState>();

  void _loginNow() async {
    var isvalid = _form.currentState!.validate();
    if (!isvalid) {
      return;
    }
    _form.currentState!.save();
    bool istoken = await Provider.of<UserState>(context, listen: false).loginNow(_username, _password);
    if (istoken) {
      Navigator.of(context).restorablePushReplacementNamed(HomeScreen.routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Something is Wrong. Please Try Again!"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Okay"),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.red.shade900,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please Enter Your username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Username",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSaved: (v) {
                    _username = v ?? '';
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        // Toggle the obscureText state
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  onSaved: (v) {
                    _password = v ?? '';
                  },
                  obscureText: _obscureText,
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _loginNow,
                  child: Text("Login"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red.shade900),
                    textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                SizedBox(height: 12),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).restorablePushNamed(RegisterScreen.routename);
                    },
                    child: Text("Create Account"),
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