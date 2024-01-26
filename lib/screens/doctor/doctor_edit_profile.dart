import 'package:dr_detection/controllers/signin_signup_controller.dart';
import 'package:dr_detection/widgets/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorEditProfilescreen extends StatefulWidget {
  @override
  State<DoctorEditProfilescreen> createState() => _DoctorEditProfilescreenState();
}

class _DoctorEditProfilescreenState extends State<DoctorEditProfilescreen> {


  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController spcController = TextEditingController();
  String gender = 'Male';
  final controller = Get.put(SigninSignupController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Eye.PNG', // Replace with your image path
                width: 150, // Adjust width as needed
                height: 150, // Adjust height as needed
                // You can add more properties to customize the image display
              ),
              Text(
                'Edit Doctor Profile',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              buildShadowedTextField(
                controller: firstNameController,
                hintText: 'Enter your first name',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              buildShadowedTextField(
                controller: lastNameController,
                hintText: 'Enter your last name',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              buildShadowedTextField(
                controller: clinicNameController,
                hintText: 'Enter your clinic name',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              buildShadowedTextField(
                controller: emailAddressController,
                hintText: 'Enter your email address',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              buildShadowedTextField(
                controller: spcController,
                hintText: 'What\'s your Speciality',
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      value: 'Male', // Default value
                      onChanged: (value) {
                        gender = value!;
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
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()async{
                    if(firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty && clinicNameController.text.isNotEmpty && dobController.text.isNotEmpty
                        && emailAddressController.text.isNotEmpty && gender!=null){

                      controller.firstName = firstNameController.text;
                      controller.lastName = lastNameController.text;
                      controller.clinicName = clinicNameController.text;
                      controller.emailAddress = emailAddressController.text;
                      controller.gender = gender;
                      controller.dob = dobController.text;
                      controller.speciality = spcController.text;
                      controller.isDoc = true;
                      showProgressDialog(context, "Editing data");
                      await controller.editDoctorProfileData(
                          isDoc: true,
                          speciality: spcController.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          clinicName: clinicNameController.text,
                          emailAddress: emailAddressController.text,
                          dob: dobController.text,
                          gender: gender
                      );



                    }else{
                      Get.snackbar("Empty fields", "Enter all fields", backgroundColor: Colors.white);
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),


                  child: Text(
                    'Save',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
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
