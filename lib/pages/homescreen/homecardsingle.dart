import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../constants/api_client.dart';
import 'datamodel.dart';
import 'home_screen.dart';
import 'homescreenviewmodel.dart';
import 'package:http/http.dart' as http;

Map? serverD;
List? data;
HomeScreeViewModel homeScreeViewModel = HomeScreeViewModel();

class SingleListItem extends StatefulWidget {
  const SingleListItem({
    Key? key,
    List? data,
  }) : super(key: key);

  @override
  State<SingleListItem> createState() => _SingleListItemState();
}

class _SingleListItemState extends State<SingleListItem> {
  void initState() {
    Apicall();
    super.initState();
  }

  Future Apicall() async {
    HomeScreeViewModel homeScreeViewModel = HomeScreeViewModel();
    //data = await homeScreeViewModel.api();
    setState(() {
      data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeCardViewModel>.reactive(
        onViewModelReady: (model) => model.ReadySetup(),
    builder: (context, model, child) =>Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: model.data == null
            ? Container(padding: EdgeInsets.symmetric(vertical: 20),
          child: const Text('Loading history...'),
              ):
        model.data?.isEmpty == true  ? Container(padding: EdgeInsets.symmetric(vertical: 20),
          child: const Text('No transactions history'),
        )  : SingleChildScrollView(
                child: Column(
                children: [
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(), //<--here
                      itemCount: model.data?.isEmpty == true ? 0 : model.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return HistorySingleItem(
                          issuer: HomeScreeViewModel.Trimstring(
                              model.data?[index]['issuer']),
                          accountDeposited: HomeScreeViewModel.Trimstring(
                              model.data?[index]['scanAccntNo'].toString()),
                          amount: HomeScreeViewModel.Trimstring(
                              model.data?[index]['amount'].toString()),
                        );
                      }),
                ],
              ))), viewModelBuilder: ()=>HomeCardViewModel());
  }
}

class HomeCardViewModel extends ChangeNotifier{



  List? data;
  bool? load = false;

  void ReadySetup()async{
    apicall();


  }


  void apicall()async{
    ApiClient apiClient = ApiClient();
    data = await apiClient.getTransactions() as List?;
    notifyListeners();

    print(" this is the dataaaaaaaaaaaaaaaaaaaa");
    print(data);


    load = true;
    notifyListeners();
  }
}

class Transactions {
  String? amount;
  String? accountName;
  String? accountNumber;

  Transactions({required amount, required accountNumber, required accountName});
  // factory Transactions.fromMap(Map<String, dynamic> json) {
  //   return Transactions(
  //     json['account'],
  //     json['accountName'],
  //     json['accountNumber'],
  //   );
  // }

  // Transactions(this.amount, this.accountName, this.accountNumber);
  // factory Transactions.fromMap(Map<String, dynamic> json) {
  //   return Transactions(
  //     json['account'],
  //     json['accountName'],
  //     json['accountNumber'],
  //   );
  // }

  // List<Transactions> parseTransactions(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<Transactions>((json) =>Transactions.fromJson(json)).toList();
  // }
  // Future<List<Transactions>> fetchTransactions() async {
  //   final response = await http.get('http://192.168.1.2:8000/products.json');
  //   if (response.statusCode == 200) {
  //     return parseTransactions(response.body);
  //   } else {
  //     throw Exception('Unable to fetch products from the REST API');
  //   }
  // }
}
