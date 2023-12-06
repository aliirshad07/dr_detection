import 'package:dr_detection/screens/otp_screen.dart';
import 'package:dr_detection/screens/user_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SigninSignupController extends GetxController{
  final GetStorage _box = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Global variable to store the user's UID
  String? uid;

  RxBool _isLoggedIn = false.obs;

  bool get isLoggedIn => _isLoggedIn.value;





  Future<void> signupUserWithEmailAndPassword(String email, String password, String confirmPassword) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).whenComplete(() => _isLoggedIn.value= true);

      // Get the user's UID
      uid = userCredential.user!.uid;

      // Show a success snackbar
      Get.snackbar('Success', 'User signed up successfully', backgroundColor: Colors.white);


      // You can add additional logic here, such as navigating to a new screen after signup
    } catch (e) {
      // Show an error snackbar with the error message
      Get.snackbar('Error', 'Failed to sign up user: $e');
    }
  }

  Future<void> signinUserWithEmailAndPassword(String email, String password,) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).whenComplete(() => _isLoggedIn.value= true);


      // Show a success snackbar
      Get.snackbar('Success', 'User signed in successfully', backgroundColor: Colors.white);


      // You can add additional logic here, such as navigating to a new screen after signup
    } catch (e) {
      // Show an error snackbar with the error message
      Get.snackbar('Error', 'Failed to sign in user: $e');
    }
  }
}