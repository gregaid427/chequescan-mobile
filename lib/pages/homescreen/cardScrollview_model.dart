import 'dart:convert';

import 'package:http/http.dart' as http;



class CardScrollViewModel {

  Map? serverD;
  List? data;

  Future Apicall1() async {
    http.Response response;
    response = await http.get(Uri.parse("http://192.168.43.53:5000/api/Transactions"));
    print(response);
    if(response.statusCode == 200){
      print("called");
      serverD = json.decode(response.body);
      data = serverD?['data'];
return data;
      // setState(() {
      //   serverD = json.decode(response.body);
      // });
    }
  }

  List<Map<String, dynamic>> cardItems = [
    {
      "accountType": "Visa Card",
      "accountNumber": "2467 4534 4532 6654",
      "scanneedNumber": "25",
      "TotalscanneedAmount": "25, 000.00",
    },
    {
      "accountType": "Savings",
      "accountNumber": "2467 4534 4532 6654",
      "scanneedNumber": "25",
      "TotalscanneedAmount": "25, 000.00",
    },
    {
      "accountType": "Current ",
      "accountNumber": "2467 4534 4532 6654",
      "scanneedNumber": "25",
      "TotalscanneedAmount": "25, 000.00",
    },
  ];



}