import 'package:chequescan/pages/authentication/sign_in/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/api_client.dart';

import '../../../constants/pagetransitions.dart';
import '../../homescreen/home_screen.dart';

class OtpViewModel extends ChangeNotifier {
  bool hasError = false;
  bool hasError1 = false;
  String currentText = "";
  String resendnotify="";
  dynamic? data;

  void ResendOtp(context) async {
    ApiClient apiClient = ApiClient();
    data =  await apiClient.ResetOTP(context);
    notifyListeners();
    print(data);
    if (data.statusCode == 200)  {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
       prefs.setString("otpCode", data.data['data'].toString());

      resendnotify = "New code has been sent";
      notifyListeners();
    }
    else {
      resendnotify = "Unable to send new code, Try again";
      notifyListeners();
    }
    }

void setPin(pin){
   currentText = pin;
   notifyListeners();

}

 dynamic validateOtp(context) async {
    EasyLoading.show(status: 'Verifying...');
print(currentText.length);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pin = prefs.getString("otpCode");
    print(pin);
    if (currentText.length != 4) {
      EasyLoading.dismiss();

      hasError = true;
      notifyListeners();
    } else {
      if (currentText != '0000') {
        EasyLoading.dismiss();

        hasError1 = true;
        notifyListeners();

        hasError = false;
        notifyListeners();
      }
      if (currentText == '0000') {
        EasyLoading.dismiss();
        // EasyLoading.showSuccess('Success!');

        ApiClient apiClient = ApiClient();
        data =  await apiClient.UpdateVerification(context);

        hasError = false;
        notifyListeners();

        hasError1 = false;
        notifyListeners();

        final SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setBool("verifiedOtp",true);

        print('correct pin');
        // userPreferences.setUserStatus(2);
        if(data == 200)
        Navigator.push(context, SizeTransition5(LoginScreen()));
      }
      ;

    }
  }
}
