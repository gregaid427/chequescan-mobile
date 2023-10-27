import 'package:chequescan/components/%20custom_appbar.dart';
import 'package:chequescan/components/rounded_button.dart';
import 'package:chequescan/constants/constants.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chequescan/pages/homescreen/home_screen.dart';
import 'package:stacked/stacked.dart';
import '../../constants/pagetransitions.dart';
import '../../core/custom_textfield1.dart';
import '../../core/enums/textfield_type.dart';
import 'linknewaccountmodel.dart';


class LinkNewAccount extends StatelessWidget {
  LinkNewAccount({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    SuccessAlert() {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        title: 'Completed successfully!',
        // text: 'Completed successfully!',
        barrierDismissible: true,
        confirmBtnText: 'Ok',
        // widget:
        closeOnConfirmBtnTap: false,
        onConfirmBtnTap: () async {
          Navigator.pushReplacement(
            context,
            SlideTransition1(
              HomeScreen(),
            ),
          );
          // await Future.delayed(const Duration(milliseconds: 500), () async {
          //   await CoolAlert.show(
          //     context: context,
          //     type: CoolAlertType.success,
          //     text: "Phone number '$message' has been saved!.",
          //   );
          // });
        },
      );
    }

    ErrorAlert() {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        title: 'Error!',
        text: 'Sorry, something went wrong, Try again',
        loopAnimation: false,
      );
    }
    return ViewModelBuilder<LinkAccountModel>.reactive(
        builder: (context, model, child) =>
      SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const CustomAppbar(),
            const Text('Link New Account', style: kTitleStyle),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Container(
                          child: Column(
                        children: [
                          Form(
                              key: _formKey,
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 50.0),
                                  const Text(
                                    '      Account Type',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  SizedBox(height: 2.0),
                                  CustomTextField1(
                                    hintText: '',
                                    obscure: false,
                                    type: TextFieldType.name,
                                    inputType: TextInputType.text,
                                    onChanged: (value){model.accountType = value; },
                                  ),
                                  SizedBox(height: 10.0),
                                  const Text(
                                    '      Bank',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  SizedBox(height: 2.0),
                                  CustomTextField1(
                                    hintText: '',
                                    obscure: false,
                                    type: TextFieldType.name,
                                    inputType: TextInputType.text,
                                    onChanged: (value){model.bank = value; },

                                  ),
                                  SizedBox(height: 10.0),
                                  const Text(
                                    '      Account Name',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  SizedBox(height: 2.0),
                                  CustomTextField1(
                                    hintText: '',
                                    obscure: false,
                                   // type: TextFieldType.name,
                                    inputType: TextInputType.text,
                                    onChanged: (value){model.accountName = value; },

                                  ),
                                 SizedBox(height: 10.0),
                                  const Text(
                                    '      Account Number',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  SizedBox(height: 2.0),
                                  CustomTextField1(
                                    hintText: '',
                                    obscure: false,
                                    type: TextFieldType.name,
                                    inputType: TextInputType.text,
                                    onChanged: (value){model.accountNumber = value; },

                                  ),
                                 const SizedBox(height: 50),

                                  Align( alignment: Alignment.center,
                                    child: RoundedButton(
                                      title: 'Continue',
                                      color: Colors.white,
                                      backgroundColor: kPrimaryColor,
                                      press: () async{
                                       int responseCode = await model.LinkAccountService();
                                       if(responseCode == 200){
                                         SuccessAlert();
                                       }
                                       else{
                                         ErrorAlert();
                                       }
                                      },
                                    ),
                                  ),],
                              )
                          )
                        ],
                      )),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ), viewModelBuilder: ()=>LinkAccountModel() ,);
  }
}
