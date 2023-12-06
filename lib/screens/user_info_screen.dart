import 'package:dr_detection/Hscreen.dart';
import 'package:dr_detection/controllers/signin_signup_controller.dart';
import 'package:dr_detection/screens/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_profile_controller.dart';

class GetUserInfoScreen extends StatefulWidget {
  @override
  State<GetUserInfoScreen> createState() => _GetUserInfoScreenState();
}

class _GetUserInfoScreenState extends State<GetUserInfoScreen> {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  final userProfileController = Get.put(UserProfileController());
  final controller = Get.put(SigninSignupController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            buildShadowedTextField(
              controller: firstNameController,
              hintText: 'Enter your first name',
              keyboardType: TextInputType.text,
              onChanged: (value){
                userProfileController.setFirstName(value);
              }
            ),
            SizedBox(height: 16.0),
            buildShadowedTextField(
              controller: lastNameController,
              hintText: 'Enter your last name',
              keyboardType: TextInputType.text,
                onChanged: (value){
                  userProfileController.setLastName(value);
                }
            ),
            SizedBox(height: 16.0),
            buildShadowedTextField(
              controller: emailAddressController,
              hintText: 'Enter your email address',
              keyboardType: TextInputType.emailAddress,
                onChanged: (value){
                  userProfileController.setEmailAddress(value);
                }
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    value: 'Male', // Default value
                    onChanged: (value) {
                      userProfileController.setGender(value!);
                    },
                    items: ['Male', 'Female', 'Other'].map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: buildShadowedTextField(
                    controller: dobController,
                    hintText: 'DOB',
                    keyboardType: TextInputType.text,
                    onChanged: (value){
                      userProfileController.setDob(value);
                    }
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()async{
                  if(firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty && dobController.text.isNotEmpty
                      && emailAddressController.text.isNotEmpty && genderController.text.isNotEmpty
                  ){
                    await userProfileController.saveUserProfileDetails();
                    Get.offAll(()=> MyHomePage());
                  }else{
                    Get.snackbar("Empty fields", "Enter all fields", backgroundColor: Colors.white);
                  }

                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShadowedTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    bool isPassword = false,
    onChanged(val)?
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}