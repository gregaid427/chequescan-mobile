
//import 'package:chequescan/pages/transactions/transactions_preview.dart';
import 'dart:io';
//import 'dart:js_interop';

import 'package:chequescan/constants/api_client.dart';
import 'package:chequescan/pages/transactions/transactions_preview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../../components/ custom_appbar.dart';
import '../../components/home_card.dart';
import '../../components/rounded_button.dart';
import '../../constants/constants.dart';
import '../../core/provider/Transactionsdata.dart';
import '../homescreen/cardscrollview.dart';
import '../newaccount/link_new_account.dart';
import '../scan/scanpage2.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'depositChequeModel.dart';

enum TransferType { Express, Normal }


class DepositPreview extends StatefulWidget with ChangeNotifier {
  DepositPreview({Key? key}) : super(key: key);

  @override
  State<DepositPreview> createState() => _DepositPreviewState();
}



TransactionsData transactionsData = TransactionsData();


class _DepositPreviewState extends State<DepositPreview> {
  void initState() {
    super.initState();
  }

  String Type = "Express";



  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<DepositChequeViewModel>.reactive(
      onViewModelReady: (model) => model.ReadySetup(),
      builder: (context, model, child) => Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SafeArea(
            child: Column(children: [
          CustomAppbar(),
          const Text('Deposit Cheque', style: kTitleStyle),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
            SizedBox(height: 10),
            const Align(
                alignment: Alignment.topLeft,
                child: Text('Front', style: kTitleStyle)),
            SizedBox(height: 5),
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.40,
                child: Center(
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: Text(
                          "Image loading...",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      Image.file(File(Provider.of<TransactionsData>(context)
                          .getfrontImagelink))
                    ],
                  ),
                )),
            const SizedBox(height: 20),
            Divider(
              thickness: 3,
            ),
            SizedBox(height: 10),
            const Align(
                alignment: Alignment.topLeft,
                child: Text('Back', style: kTitleStyle)),
            SizedBox(height: 5),
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.40,
                child: Center(
                  child: Stack(
                    children: [
                      const Positioned(
                        child: Text("Image loading...",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        top: 0,
                        right: 0,
                        left: 0,
                        bottom: 0,
                      ),
                      Image.file(File(Provider.of<TransactionsData>(context)
                          .getbackImagelink))
                    ],
                  ),
                )),
            GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.40,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          left: 30,
                          right: 30,
                          bottom: 15,
                        ),
                        child: Column(
                          //  crossAxisAlignment: CrossAxisAlignment.start,
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Select Account',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: kPrimaryColor,
                              ),
                            ),

                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              color: Color.fromRGBO(242, 242, 242, 1),
                              height: 2,
                              thickness: 1,
                              indent: 0,
                              endIndent: 0,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            //  for (String item in values)

                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: model.getdatalength() ? Column(
                                  children: List.generate(

                                     model.data!.length,
                                    (index) =>
                                         GestureDetector(
                                            onTap: () {
                                            setState(() {
                                                model.ShowErrorText1 = false;
                                                model.ShowErrorText = true;
                                              });
                                              Navigator.pop(context);

                                              Provider.of<TransactionsData>(
                                                      context,
                                                      listen: false)
                                                  .setChosenAccount(model.data![index]
                                                          ["accountNumber"]
                                                      .toString());
                                              Provider.of<TransactionsData>(
                                                      context,
                                                      listen: false)
                                                  .setChosenAccountid(
                                                      model.data![index]["accountid"]
                                                          .toString());

                                              Provider.of<TransactionsData>(
                                                      context,
                                                      listen: false)
                                                  .setChosenAccountType(
                                                      model.data![index]
                                                              ["accountType"]
                                                          .toString());

                                              Provider.of<TransactionsData>(
                                                      context,
                                                      listen: false)
                                                  .setbank(model.data![index]["bank"]
                                                      .toString());

                                              setState(() {

                                                model.setdropdown("${model.data![index]["accountNumber"].toString().substring(0, 10)} (${model.data![index]["accountName"].toString().substring(0, 8)})");

                                              });
                                            },
                                            child: Column(
                                              children: [
                                                Text(model.data![index]["accountNumber"]),
                                                Text(
                                                  "${model.data![index]["accountName"].toString()}",
                                                  style:
                                                      TextStyle(fontSize: 17),
                                                ),
                                                Divider()
                                              ],
                                            ),
                                          )

                                  ),
                                )
                                :    Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                  const Text('No Linked Accounts'),
                              SizedBox(height: 30,),
                              Padding(
                                padding: const EdgeInsets.all(35.0),
                                child: RoundedButtonborders(
                                    title: 'Link an account',
                                    color: Colors.white,
                                    backgroundColor:
                                    kPrimaryColor,
                                    borderColor: kPrimaryColor,
                                    press: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LinkNewAccount()));
                                    }),
                              )
                              ],
                            ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  child: Column(
                    children: [
                      const Text(
                        'Select Account To Deposit Cheque Into',
                        style: TextStyle(fontSize: 19, color: kPrimaryColor),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                model.dropdownValue,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              //   color: Color(0xff8ab039),
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      if (model.ShowErrorText1 == true)
                        const Text(
                          "Select an Account to Continue",
                          style: TextStyle(color: Colors.red),
                        ),


                    ],
                  )),
            ),
            SizedBox(height: 10),
            const Text(
              'Select Transfer Type',
              style: TextStyle(fontSize: 19),
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: (){

                      setState(() {
                        Type = 'Express';
                      });

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column( crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Express',
                                style: TextStyle(fontSize: 19, color: Colors.orange)),
                            const Text('Transfer in 30Mins Charge: GHS 5.00',
                                style: TextStyle(fontSize: 14, color: Colors.black54)),
                          ],
                        ),
                        Radio(
                            value: 'Express',
                            groupValue: Type,
                            onChanged: (value) {
                              setState(() {
                                Type = value!.toString();
                              });
                              Provider.of<TransactionsData>(context,
                                      listen: false)
                                  .setTransferType("Express");
                            })
                      ],
                    ),
                  ),
                  InkWell( onTap: (){

                    setState(() {
                      Type = 'Normal';
                    });

                  },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column( crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Normal',
                                style: TextStyle(fontSize: 19, color: Colors.orange)),
                            Text('Transfer in 2days Charge: GHS 0.00',
                                style: TextStyle(fontSize: 14, color: Colors.black54)),
                          ],
                        ),
                        Radio(
                            value: 'Normal',
                            groupValue: Type,
                            onChanged: (value) {
                              setState(() {
                                Type = value!.toString();
                              });             Provider.of<TransactionsData>(context,
                                      listen: false)
                                  .setTransferType("Normal");
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20),
                    child: RoundedButtonborders(
                      title: 'Continue',
                      color: Colors.white,
                      backgroundColor: kPrimaryColor,
                      borderColor: kPrimaryColor,
                      press: () {

                        // String? ChosenAccount =
                        //     Provider.of<TransactionsData>(context, listen: false)
                        //         .getchosenAccount;
                        if (model.ShowErrorText1 == true)
                          model.setdropdown("Select Account");
                        if (model.ShowErrorText == null) {
                          setState(() {
                            model.ShowErrorText1 = true;
                          });
                          print("ShowErrorText");
                        } else {
                          EasyLoading.show();

                          // setState(() {
                          //   ShowErrorText = false;
                          // });

                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => const TransactionsPreviewScreen(),
                            ),
                          );
                          setState(() {
                            model.ShowErrorText = null;
                            model.ShowErrorText1 == true;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ])))
        ])),
      )),
      viewModelBuilder: () => DepositChequeViewModel(),
    );
  }
}
