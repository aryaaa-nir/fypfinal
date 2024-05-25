// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:restru/screens/login.dart';
// import '../state/userstate.dart';

// class RegisterScreen extends StatefulWidget {
//   static const routename = '/register-screen';

//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _form = GlobalKey<FormState>();
//   bool _isChecked = false;
//   String _username = '';
//   String _allergy = '';
//   bool _obscureText = true;

//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   void _registerNow() async {
//     var isValid = _form.currentState!.validate();
//     if (!isValid) {
//       return;
//     }
//     _form.currentState!.save();
//     String allergyToSave = _isChecked ? '' : _allergy;
//     bool isregister = await Provider.of<UserState>(context, listen: false)
//         .registerNow(_username, _passwordController.text, allergyToSave);
//     if (isregister) {
//       Navigator.of(context).restorablePushReplacementNamed(LoginScreen.routename);
//     } else {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Something is Wrong. Please Try Again!"),
//             actions: [
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text("Okay"))
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Register Now"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(12),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _form,
//             child: Column(
//               children: [
//                 TextFormField(
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return 'Please Enter Your Username';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Username",
//                   ),
//                   onSaved: (v) {
//                     _username = v ?? '';
//                   },
//                 ),
//                 TextFormField(
//                   controller: _passwordController,
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return 'Please Enter Your Password';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Password",
//                     suffixIcon: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _obscureText = !_obscureText;
//                         });
//                       },
//                       child: Icon(
//                         _obscureText
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                   obscureText: _obscureText,
//                   autocorrect: false,
//                   enableSuggestions: false,
//                 ),
//                 TextFormField(
//                   controller: _confirmPasswordController,
//                   validator: (v) {
//                     if (v!.isEmpty) {
//                       return 'Please Confirm Your Password';
//                     }
//                     if (v != _passwordController.text) {
//                       return 'Passwords do not match';
//                     }
//                     return null;
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Confirm Password",
//                     suffixIcon: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _obscureText = !_obscureText;
//                         });
//                       },
//                       child: Icon(
//                         _obscureText
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),
//                   obscureText: _obscureText,
//                   autocorrect: false,
//                   enableSuggestions: false,
//                 ),
//                 if (!_isChecked)
//                   TextFormField(
//                     validator: (v) {
//                       if (v!.isEmpty) {
//                         return 'Enter Your Allergy';
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       hintText: "Allergy/none",
//                     ),
//                     onSaved: (v) {
//                       _allergy = v ?? '';
//                     },
//                   ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: _registerNow,
//                       child: Text("Register"),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context)
//                             .pushReplacementNamed(LoginScreen.routename);
//                       },
//                       child: Text("Already have an account? Login"),
//                     )
//                   ],
//                 )
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
import 'package:restru/screens/login.dart';
import '../state/userstate.dart';

class RegisterScreen extends StatefulWidget {
  static const routename = '/register-screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  bool _isChecked = false;
  String _username = '';
  String _allergy = '';
  bool _obscureText = true;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _registerNow() async {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    String allergyToSave = _isChecked ? '' : _allergy;
    bool isregister = await Provider.of<UserState>(context, listen: false)
        .registerNow(_username, _passwordController.text, allergyToSave);
    if (isregister) {
      Navigator.of(context).restorablePushReplacementNamed(LoginScreen.routename);
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
                  child: Text("Okay"))
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Now"),
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
                      return 'Please Enter Your Username';
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
                  controller: _passwordController,
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
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  obscureText: _obscureText,
                  autocorrect: false,
                  enableSuggestions: false,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _confirmPasswordController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Please Confirm Your Password';
                    }
                    if (v != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  obscureText: _obscureText,
                  autocorrect: false,
                  enableSuggestions: false,
                ),
                SizedBox(height: 12),
                if (!_isChecked)
                  TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Enter Your Allergy';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Allergy/none",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                       borderSide: BorderSide.none,
                      ),
                    ),
                    onSaved: (v) {
                      _allergy = v ?? '';
                    },
                  ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _registerNow,
                      child: Text("Register"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red.shade900,
                        textStyle: TextStyle(color: Colors.white),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).restorablePushReplacementNamed(LoginScreen.routename);
                      },
                      child: Text("Already have an account? Login"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}