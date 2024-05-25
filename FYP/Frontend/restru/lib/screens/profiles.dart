import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restru/state/productstate.dart';
import 'package:restru/state/profilestate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/profile.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-details';

  final String token;

  ProfileScreen({required this.token});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileState()..fetchProfile(token),
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Profile'),
          backgroundColor: Colors.red.shade900,
        ),
        body: Consumer<ProfileState>(
          builder: (context, profileState, child) {
            if (profileState.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (profileState.error != null) {
              return Center(child: Text('Error: ${profileState.error}'));
            }

            final profile = profileState.profile;
            if (profile == null) {
              return Center(child: Text('No profile data'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Username: ${profile.user?.username ?? ''}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(height: 16),
                  Text('Allergy: ${profile.allergy ?? ''}', style: TextStyle(fontSize: 18, color: Colors.black)),
                  Text('Phone Number: ${profile.phone ?? ''}', style: TextStyle(fontSize: 18, color: Colors.black)),

                  SizedBox(height: 16),
                  // Add more profile details here
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

