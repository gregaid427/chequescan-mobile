
import 'package:flutter/cupertino.dart';

import '../../constants/api_client.dart';


class DepositChequeViewModel extends ChangeNotifier {

  bool? load = false;
  String dropdownValue = "Select Account";


  void resetdropdown() {
      dropdownValue = "Select Account";
      notifyListeners();
  }
  void setdropdown(value) {
    dropdownValue = value;
    notifyListeners();
    print(dropdownValue);
  }
  List? data;

  void apicall()async{
    ApiClient apiClient = ApiClient();
    data = await apiClient.getUserLinkedaccount() as List?;
    notifyListeners();

    load = false;
    notifyListeners();

  }

  void ReadySetup()async{
    resetdropdown();
    apicall();
  }

  bool getdatalength() {
    bool  value =  data?.length != 0 ?  true : false ;

    return value;
  }

  // String Type = "Express";
  //
  // void ChangeType(value) {
  //   Type = value!.toString();
  //   notifyListeners();
  // }



  bool? ShowErrorText;
  bool? ShowErrorText1 = true;





}

// Future getUserLinkedaccount() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//   String? userid = prefs.getString("user_id");
//   http.Response response;
//   response = await http.get(Uri.parse("$_appUrl.userlinkedaccount+$userid"));
//   if (response.statusCode == 200) {
//     dynamic serverD = json.decode(response.body);
//     dynamic data = serverD?['data'];
//     print(serverD?['data']);
//     return data;
//   }
//   else{
//     return response.statusCode;
//   }
// }
