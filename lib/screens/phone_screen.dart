import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'otp_screen.dart';


class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {

  TextEditingController phoneController = TextEditingController();
  var phone = '';
  String countrycode = "+92";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            keyboardType: TextInputType.phone,
            controller: phoneController,
            decoration: InputDecoration(
                hintText: "Enter phone number",
                label: Text("Enter phone number")
            ),
            onChanged: (val){
              phone = val;
            },
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: ()async{
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: '${countrycode + phone}',
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (String verificationId, int? resendToken) {
                  Get.to(()=> OTPScreen(verificationId: verificationId,));
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );

            },
            child: Text('Send code'),
          )
        ],
      ),
    );
  }
}
