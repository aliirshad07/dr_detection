import 'package:dr_detection/controllers/signin_signup_controller.dart';
import 'package:dr_detection/screens/phone_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dr_detection/Hscreen.dart';
import "package:flutter_easyloading/flutter_easyloading.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final userController = Get.put(SigninSignupController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialBinding: BindingsBuilder(() {
        Get.put<SigninSignupController>(userController);
      }),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData){
              return MyHomePage();
            }else if(snapshot.hasError){
              return Center(
                  child: Text('${snapshot.error}')
              );
            }
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return PhoneScreen();
        },
      ),
      builder: EasyLoading.init(),
    );
  }
}
