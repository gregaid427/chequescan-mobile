import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/api_client.dart';
import '../../../constants/app_url.dart';
import '../../../constants/shared_preference.dart';
import '../otp/otp_screen.dart';
import 'package:http/http.dart' as http;

class SignupViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController otherNameController = TextEditingController();
  final TextEditingController ghanaCardController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  // var  email = emailController.text,
  //  "firstname": firstNameController.text,
  //  "lastname": lastNameController.text,
  //  "othername": otherNameController.text,
  //  "ghCardNumber": ghanaCardController.text,
  //  "contact": contactController.text,
  //  "role": '100',
  //  "password": passwordController.text,

  final ApiClient _apiClient = ApiClient();
  bool obscure = true;

  void changePasswordvisibility() {
    obscure = !obscure;
    notifyListeners();
  }

  Future<void> registerUsers(context) async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Creating account...');
      Map<String, dynamic> userData = {
        "email": emailController.text,
        "password": passwordController.text,
        "contact": contactController.text,
        "role": "null",
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
        "othername": otherNameController.text,
        "ghCardNumber": ghanaCardController.text,
        "sex": "null",
        "createdAt": 'null',
        "dob": "null"
      };

      EasyLoading.show(status: 'Authenticating...');
      final ApiClient _apiClient = ApiClient();

      dynamic response = await _apiClient.registerUser(userData, context);

      dynamic res = response.body;
      int? statuscode = response.statusCode;
      print(response);
      if (statuscode == 200) {
        print(response);

        UserPreferences userPreferences = UserPreferences();
        var statuscode = response.statusCode;
        if (statuscode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body);

          if (data["success"] == 0) {
            EasyLoading.dismiss();
            userPreferences.setUserStatus(1);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //  content: Text('Error: Unable to create account - ${res['message']}'),
              content: Text('Error: Unable to create account'),

              backgroundColor: Colors.red.shade300,
            ));
          }
          if (data["success"] == 1) {
            EasyLoading.dismiss();
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setString('otpCode', data['userPin'].toString());
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => OtpScreen()));
          }
        }
        if (statuscode! >= 400) {
          print("App Error");
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: Unable to create account'),
            backgroundColor: Colors.red.shade300,
          ));
        }
      }
    }
  }
}
