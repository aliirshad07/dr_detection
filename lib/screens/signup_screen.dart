import 'package:dr_detection/controllers/signin_signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_info_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final controller = Get.put(SigninSignupController());
  @override
  Widget build(BuildContext context) {

    void _showUploadDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(color: Colors.black,),
                SizedBox(height: 10),
                Text('Logging in...'),
              ],
            ),
          );
        },
      );
    }
    return Scaffold(
      body: Column(
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
          buildTextField(
            hintText: "Enter your email",
            controller: emailController,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 16.0),
          buildTextField(
            hintText: "Enter password",
            controller: passwordController,
            keyboardType: TextInputType.text,
            isPassword: true,
          ),
          SizedBox(height: 16.0),
          buildTextField(
            hintText: "Confirm password",
            controller: confirmPasswordController,
            keyboardType: TextInputType.text,
            isPassword: true,
          ),
          SizedBox(height: 16.0),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: ()async{

                if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty){
                  if(passwordController.text == confirmPasswordController.text){
                    _showUploadDialog();
                    await controller.signupUserWithEmailAndPassword(
                        emailController.text,
                        passwordController.text, confirmPasswordController.text
                    ).whenComplete(() => Get.to(()=> GetUserInfoScreen()));
                  }else{
                    Get.snackbar('Error', 'Password does not match', backgroundColor: Colors.white);
                  }
                }else{
                  Get.snackbar('Empty fields', 'Please enter all fields', backgroundColor: Colors.white);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
              ),
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class buildTextField extends StatelessWidget {
  const buildTextField({
    super.key, required this.controller, required this.hintText, required this.keyboardType, this.isPassword=false
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;


  @override
  Widget build(BuildContext context) {
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

