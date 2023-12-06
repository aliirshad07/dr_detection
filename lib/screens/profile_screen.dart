import 'package:dr_detection/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_profile_controller.dart';

class ProfileScreen extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_power_rounded),
            onPressed: ()async{
              try {
                await _auth.signOut().whenComplete(() => Get.to(()=> LoginScreen()));
                // Clear stored user data, such as UID and authentication state
              } catch (e) {
                print('Error signing out: $e');
              }
            },

          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<UserProfileController>(
          builder: (userProfileController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileItem('Name', userProfileController.firstName + " " + userProfileController.lastName),
                _buildProfileItem('Email', userProfileController.emailAddress),
                _buildProfileItem('Date of Birth', userProfileController.dob),
                _buildProfileItem('Gender', userProfileController.gender),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.black),
          ),
          child: Text(
            value ?? "None",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
