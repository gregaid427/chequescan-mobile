import 'dart:io';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:chequescan/core/provider/Transactionsdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../components/ custom_appbar.dart';
import '../../components/rounded_button.dart';
import '../../constants/constants.dart';
import '../scan/scanpage2.dart';
import '../transactions/depositcheque.dart';
import 'back_cheque_scan_model.dart';
//import '../transactions/transactions_preview.dart';

class BackScanPage extends StatefulWidget {
  final String frontimagevalue;
  const BackScanPage({Key? key, required this.frontimagevalue}) : super(key: key);

  @override
  State<BackScanPage> createState() => _BackScanPageState();
}

class _BackScanPageState extends State<BackScanPage> {
  //TransactionsData transactionsData = new TransactionsData();
  @override
  void initState() {
    EasyLoading.dismiss();

    super.initState();
  }

  //BackscanViewModel backscanModel = BackscanViewModel();
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog1() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('AlertDialog Title'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('000000000000000000000000000000000000000'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return ViewModelBuilder<BackscanViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppbar(),
            const Text('Please endorse and scan back of cheque', style: kTitleStyle),
            const Text('( Endorse with signature and date )', style: TextStyle(fontSize: 18, color: kPrimaryColor),),

            Expanded(
              child: Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //     if ( imageFile != null) const CircularProgressIndicator(),
                      // if ( imageFile != null) const _showMyDialog1(),
                      if (!model.textScanning && model.imageFile == null)
                        Container(
                          width: 300,
                          height: 300,
                          child: const Image(
                            image: AssetImage('assets/images/scanimg.PNG'),
                            // height: screenHeight * 0.22,
                          ),
                        ),
                      if (!model.textScanning && model.imageFile == null)
                        Spacer(),
                      if (!model.textScanning && model.imageFile == null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: RoundedButtonborders(
                                    title: 'Camera',
                                    backgroundColor: Colors.white,
                                    color: kPrimaryColor,
                                    borderColor: kPrimaryColor,
                                    press: () => model.getImage(ImageSource.camera,context)),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: RoundedButtonborders(
                                    title: ' Gallery ',
                                    backgroundColor: Colors.white,
                                    color: kPrimaryColor,
                                    borderColor: kPrimaryColor,

                                    press: () => model.getImage(ImageSource.gallery,context)),
                              ),
                            ),                          ],
                        ),

                      // if (imageFile == null)
                      //   SpinKitChasingDots(),

                      if (model.imageFile != null)
                        Container(
                            child: model.showNext != true
                                ? const Padding(
                              padding: EdgeInsets.only(top: 100.0),
                              child: CircularProgressIndicator(),
                            )
                                : Expanded(
                                child: Image.file(File(model.imageFile!.path)))),

                      //

                      const SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   child: Text(
                      //     scannedText,
                      //     style: TextStyle(fontSize: 20),
                      //   ),
                      // ),


                      Align(
                        alignment: Alignment.bottomCenter,
                        child: model.showNext != true
                            ? null
                            :Container(
                          child:  Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.3,
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
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .pop();
                                                    model.getImage(
                                                        ImageSource.camera,context);
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        vertical: 13),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5),
                                                    color: kPrimaryColor,
                                                    child: const Center(
                                                        child: Text(
                                                          "Camera",
                                                          style: TextStyle(
                                                              fontSize: 19,
                                                              color:
                                                              Colors.white),
                                                        )),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .pop();
                                                    model.getImage(ImageSource
                                                        .gallery,context);
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                        vertical: 13),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 5),
                                                    color: kPrimaryColor,
                                                    child: const Center(
                                                        child: Text(
                                                          "Gallery",
                                                          style: TextStyle(
                                                              fontSize: 19,
                                                              color:
                                                              Colors.white),
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const RoundedButtonborders(
                                    title: ' Rescan ',
                                    color: kPrimaryColor,
                                    borderColor: kPrimaryColor,

                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5, width: 10,),
                              Expanded(
                                child: RoundedButtonborders(
                                  title: 'Continue',
                                  color: Colors.white,
                                  backgroundColor: kPrimaryColor,
                                  borderColor: kPrimaryColor,
                                  press: () {
                                    //  backscanModel.imageFile1 = imageFile;
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (_) =>  DepositPreview(),
                                      ),
                                    );
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    ), viewModelBuilder: ()=> BackscanViewModel());
  }




}

//
// class RescanAlert extends StatelessWidget {
//   const RescanAlert({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('AlertDialog Title'),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('This is a demo alert dialog.'),
//                 Text('Would you like to approve of this message?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Approve'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
// }
//
//
// }
