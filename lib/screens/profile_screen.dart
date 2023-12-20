import 'package:dr_detection/controllers/signin_signup_controller.dart';
import 'package:dr_detection/screens/login_screen.dart';
import 'package:dr_detection/screens/phone_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_profile_controller.dart';

class ProfileScreen extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final controller = Get.put(SigninSignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Profile',
        style: TextStyle(
          color: Colors.white
        ),),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_power_rounded, color: Colors.white,),
            onPressed: ()async{
              try {
                await _auth.signOut().whenComplete(() => Get.offAll(()=> LoginScreen()));
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileItem('Name', controller.firstName + " " + controller.lastName),
            _buildProfileItem('Email', controller.emailAddress),
            _buildProfileItem('Date of Birth', controller.dob),
            _buildProfileItem('Gender', controller.gender),
          ],
        )
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
          width: double.maxFinite,
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
