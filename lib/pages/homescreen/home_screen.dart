import 'dart:convert';
import 'dart:developer';

import 'package:chequescan/components/rounded_button.dart';
import 'package:chequescan/pages/authentication/sign_in/signin_screen.dart';
import 'package:chequescan/pages/newaccount/link_new_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../constants/shared_preference.dart';
import '../../components/ custom_appbar.dart';
import '../../constants/constants.dart';
import '../chequefrontscan/front_cheque_scan.dart';
import '../scan/Screen/recognization_page.dart';
import '../scan/Utils/image_cropper_page.dart';
import '../scan/Utils/image_picker_class.dart';

import '../scan/scanpage.dart';
import 'cardScrollview_model.dart';
import 'cardscrollview.dart';
import 'homecardsingle.dart';
import 'homescreenviewmodel.dart';



class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}
UserPreferences userPreferences = UserPreferences();



class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    CardScrollViewModel cardScrollViewModel = CardScrollViewModel();

    void initState() {
      userPreferences.setUserStatus(2);
      super.initState();
    }

    return ViewModelBuilder<HomeScreeViewModel>.reactive(
        //   onViewModelReady: (model) => model.ReadySetup(),
        builder: (context, model, child) =>SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomAppbar(),
            Container(
              height: screenHeight * 0.30,
              child: Column(
                children: [
                  Image(
                    image: AssetImage('assets/images/scanimg.PNG'),
                    height: screenHeight * 0.22,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => FrontScanPage(),
                                      ),
                                    );

                      // log("Gallery");
                      // pickImage(source: ImageSource.gallery).then((value) {
                      //   if (value != '') {
                      //     imageCropperView(value, context).then((value) {
                      //       if (value != '') {
                      //         Navigator.push(
                      //           context,
                      //           CupertinoPageRoute(
                      //             builder: (_) => RecognizePage(
                      //               path: value,
                      //             ),
                      //           ),
                      //         );
                      //       }
                      //     });
                      //   }
                      // });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Scan Cheque",
                          style: TextStyle( color: kPrimaryColor,
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
            CardScrollView(),
            const LinkAccountText(),
            const History(),
            const Flexible(child: SingleListItem())
          ],
        ),
      ),
    ), viewModelBuilder: ()=>HomeScreeViewModel());
  }
}


class HistorySingleItem extends StatelessWidget {
  const HistorySingleItem({
    Key? key,
    this.issuer,
    this.accountDeposited,
    this.amount,
  }) : super(key: key);
  final issuer;
  final accountDeposited;
  final amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 6, child: Text(issuer, style: kHistoryStyle1)),
        Expanded(flex: 6, child: Text(accountDeposited, style: kHistoryStyle1)),
        Expanded(
            flex: 4,
            child: Align(
                alignment: Alignment.topRight,
                child: Text(amount.toString(), style: kHistoryStyle1))),
      ],
    );
  }
}

class History extends StatelessWidget {
  const History({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: Colors.grey.shade200,
          width: double.infinity,
          child: const Text(
            "Recent History",
            style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Issuer', style: kHistoryStyle),
              Text('      Account Deposit', style: kHistoryStyle),
              Text('Amount', style: kHistoryStyle),
            ],
          ),
        )
      ],
    );
  }
}

class LinkAccountText extends StatelessWidget {
  const LinkAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LinkNewAccount()));
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.add_circled,
              color: kPrimaryColor,
              size: 32,
            ),
            Text(
              'Link New Account',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}

void imagePickerModal(BuildContext context,
    {VoidCallback? onCameraTap, VoidCallback? onGalleryTap}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 220,
          child: Column(
            children: [
              GestureDetector(
                onTap: onCameraTap,
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: const Text("Camera",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      });
}
