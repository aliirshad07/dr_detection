import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_detection/controllers/signin_signup_controller.dart';
import 'package:dr_detection/widgets/functions.dart';
import 'package:dr_detection/widgets/text_field.dart';
import 'package:dr_detection/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.put(SigninSignupController());


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Eye.png'),
            SizedBox(height: 16.0),
            Text(
              'Sign In',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue[800],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            buildTextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              hintText: "Enter your email",
            ),
            SizedBox(height: 16.0),
            buildTextField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              hintText: "Enter your password",
              isPassword: true,
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async{
                  if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                    showProgressDialog(context, "Logging in");
                    await controller.signinUserWithEmailAndPassword(emailController.text, passwordController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(width: 4.0),
                InkWell(
                  onTap: ()=> Get.to(()=> SignUpScreen()),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

