import 'package:flutter/cupertino.dart';

import '../../constants/api_client.dart';

class TransactionPreviewModel extends ChangeNotifier {

  bool? load = false;
  String dropdownValue = "Select Account";

  List? data;

  void apicall()async{
    // ApiClient apiClient = ApiClient();
    // data = await apiClient.getBanks(1) as List?;
    // notifyListeners();

    load = false;
    notifyListeners();

  }

  void ReadySetup()async{
    apicall();
  }

  bool getdatalength() {
    bool  value =  data?.length != 0 ?  true : false ;

    return value;
  }


}