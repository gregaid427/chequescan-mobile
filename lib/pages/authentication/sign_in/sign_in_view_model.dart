import 'package:chequescan/pages/authentication/otp/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/api_client.dart';
import '../../../constants/shared_preference.dart';
import '../../../constants/user.dart';
import '../../../constants/pagetransitions.dart';
import '../../homescreen/home_screen.dart';
import '../sign_up/signup_screen.dart';

class SignInViewModel extends ChangeNotifier {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscure = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ApiClient _apiClient = ApiClient();

  final UserPreferences _userPreferences = UserPreferences();


  Future<void> login(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? verified = prefs.getBool("verifiedOtp");


    if (formKey.currentState!.validate()) {

      EasyLoading.show( status: 'Authenticating...');

      dynamic response = await _apiClient.login(
        emailController.text,
        passwordController.text,
        context
      );

      dynamic res = response.data;
      int? statuscode = response.statusCode;
     print(response);
      if(statuscode == 200){
        print("Entered");
        if (res['success'] == 1 && res['data']['verified'] == 'false') {
          EasyLoading.dismiss();
          //  String accessToken = res['access_token'];
          print(res['verified']);

          var userData = res['data'];
          UserPreferences().saveUser(User.fromJson(userData));
          //  userPreferences.setUserStatus(2);
          Navigator.pushReplacement(context,SizeTransition5(OtpScreen()));
        }
        if (res['success'] == 1 && res['data']['verified'] == 'true') {
          EasyLoading.dismiss();
          //  String accessToken = res['access_token'];
          print(res['verified']);

          var userData = res['data'];
          UserPreferences().saveUser(User.fromJson(userData));
          userPreferences.setUserStatus(2);
          Navigator.pushReplacement(context,SizeTransition5(HomeScreen()));
        }

        if (res['success'] == 0 ) {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${res['message']}'),
            backgroundColor: Colors.red.shade300,
          ));
        }
      }
      if(statuscode == 400){
        print("App Error");
        EasyLoading.dismiss();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: Unable to log in'),
          backgroundColor: Colors.red.shade300,
        ));
      }

    }
  }

  void changePasswordvisibility() {
    obscure = !obscure;
    notifyListeners();
  }

  void navigatetosignup(context) {

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
            const SignUpScreen()));
  }

}

// ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   content: const Text('Authenticating...'),
//   backgroundColor: Colors.green.shade300,
// ));

//ScaffoldMessenger.of(context).hideCurrentSnackBar();
