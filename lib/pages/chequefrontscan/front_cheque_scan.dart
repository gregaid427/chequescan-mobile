import 'dart:io';

import 'package:chequescan/core/provider/Transactionsdata.dart';
import 'package:chequescan/pages/chequefrontscan/frontChequeScanModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../components/ custom_appbar.dart';
import '../../components/rounded_button.dart';
import '../../constants/constants.dart';
import '../chequebackscan/back_cheque_scan.dart';
import '../chequebackscan/back_cheque_scan_model.dart';


class FrontScanPage extends StatefulWidget {
  const FrontScanPage({Key? key}) : super(key: key);

  @override
  State<FrontScanPage> createState() => _FrontScanPageState();
}

String? scanimageFile;

class _FrontScanPageState extends State<FrontScanPage> {
  TransactionsData transactionsData = TransactionsData();

  BackscanViewModel backscanModel = BackscanViewModel();

  @override
  Widget build(BuildContext context) {
    // modalContainer1(context){
    //   showModalBottomSheet<void>(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return Container(
    //         height: 200,
    //         color: Colors.amber,
    //         child: Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             mainAxisSize: MainAxisSize.min,
    //             children: <Widget>[
    //               const Text('Modal BottomSheet'),
    //               ElevatedButton(
    //                 child: const Text('Close BottomSheet'),
    //                 onPressed: () => Navigator.pop(context),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   );
    // }

    return ViewModelBuilder<FrontChequeScanViewModel>.reactive(
      onViewModelReady: (model) => model.ReadySetup(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppbar(),
              const Text('Scan Front of Cheque', style: kTitleStyle),
              Expanded(
                child: model.selectedbank == 'null'
                    ? ProgressIndicator(dataState: model.selectedbank)
                    : model.selectedbank == 'true'
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            //  decoration: const BoxDecoration( color: Colors.red, borderRadius: BorderRadius.horizontal(left: Radius.circular(30),right: Radius.circular(30) )
                            //),
                            // color: Colors.green,
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
                                  Spacer(),
                                  const Text(
                                    'Select Cheque Bank',
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
                                    color: Color.fromRGBO(242, 242, 242, 0.1),
                                    height: 2,
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  //  for (String item in values)

                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.0),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: model.getdatalength()
                                          ? Column(
                                              children: List.generate(
                                                  model.data!.length,
                                                  (index) => GestureDetector(
                                                        onTap: () {
                                                          // setState(() {
                                                          //   model.ShowErrorText1 = false;
                                                          //   model.ShowErrorText = true;
                                                          // });
                                                          //  Navigator.pop(context);

                                                          model
                                                              .setChequeDetails(
                                                            model.data![index]
                                                                    ["bankName"]
                                                                .toString(),
                                                            model.data![index]
                                                                ["accountNo"],
                                                            model.data![index]
                                                                ["bankNo"],
                                                            model.data![index]
                                                                ["chequeNo"],
                                                            model.data![index]
                                                            ["bankCheqNumber"],
                                                          );

                                                          EasyLoading.show();

                                                          Future.delayed(
                                                              const Duration(
                                                                  seconds: 1),
                                                              () {
                                                            model
                                                                .toggleSelectedBank();

                                                            EasyLoading
                                                                .dismiss();
                                                          });
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          3.0),
                                                              child: Text(
                                                                model.data![
                                                                        index][
                                                                    "bankName"],
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            19),
                                                              ),
                                                            ),
                                                            Divider()
                                                          ],
                                                        ),
                                                      )),
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                    'No Banks Available'),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      35.0),
                                                  child: RoundedButtonborders(
                                                      title: 'Refresh',
                                                      color: Colors.white,
                                                      backgroundColor:
                                                          kPrimaryColor,
                                                      borderColor:
                                                          kPrimaryColor,
                                                      press: () {
                                                        model.apicall();
                                                      }),
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //     if ( imageFile != null) const CircularProgressIndicator(),
                                // if ( imageFile != null) const _showMyDialog1(),
                                if (!model.textScanning &&
                                    model.imageFile == null)
                                  Container(
                                    width: 300,
                                    height: 300,
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/scanimg.PNG'),
                                      // height: screenHeight * 0.22,
                                    ),
                                  ),
                                if (!model.textScanning &&
                                    model.imageFile == null)
                                  Spacer(),

                                //  if (1==1)
                                // modalContainer1(context),
                                // modalContainer(),

                                if (!model.textScanning &&
                                    model.imageFile == null)
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
                                              press: () {
                                                model.getImage(
                                                  ImageSource.camera, context);
                                                model.setSource(ImageSource.camera);

                                              }

                                          ),
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
                                              press: () {
                                          model.getImage(
                                          ImageSource.gallery, context);
                                          model.setSource(ImageSource.gallery);

                                          }),
                                        ),
                                      ),
                                    ],
                                  ),

                                // if (imageFile == null)
                                //   SpinKitChasingDots(),

                                if (model.imageFile != null)
                                  Container(
                                      child: model.showNext != true
                                          ? const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 100.0),
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : Expanded(
                                              child: Image.file(File(
                                                  model.imageFile!.path)))),
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
                                  child: Container(
                                    child: model.showNext != true
                                        ? null
                                        : Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    showModalBottomSheet<void>(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.3,
                                                          color: Colors.white,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
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
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    model.getImage(
                                                                        ImageSource
                                                                            .camera,
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            13),
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            5),
                                                                    color:
                                                                        kPrimaryColor,
                                                                    child: const Center(
                                                                        child: Text(
                                                                      "Camera",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              19,
                                                                          color:
                                                                              Colors.white),
                                                                    )),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    model.getImage(
                                                                        ImageSource
                                                                            .gallery,
                                                                        context);
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            13),
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            5),
                                                                    color:
                                                                        kPrimaryColor,
                                                                    child: const Center(
                                                                        child: Text(
                                                                      "Gallery",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              19,
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
                                                  child:
                                                      const RoundedButtonborders(
                                                    title: ' Rescan ',
                                                    color: kPrimaryColor,
                                                    borderColor: kPrimaryColor,
                                                    backgroundColor:
                                                        Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: RoundedButtonborders(
                                                  title: 'Continue',
                                                  color: Colors.white,
                                                  backgroundColor:
                                                      kPrimaryColor,
                                                  borderColor: kPrimaryColor,
                                                  press: () {
                                                    //  backscanModel.imageFile1 = imageFile;
                                                    Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                        builder: (_) =>
                                                            BackScanPage(
                                                                frontimagevalue:
                                                                    scanimageFile!),
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
      ),
      viewModelBuilder: () => FrontChequeScanViewModel(),
    );
  }
}

class ProgressIndicator extends StatefulWidget {
  const ProgressIndicator({
    super.key,
    this.dataState,
  });
  final dataState;
  @override
  State<ProgressIndicator> createState() => _ProgressIndicatorState();
}

bool hideText = true;

class _ProgressIndicatorState extends State<ProgressIndicator> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 8), () {
// if(widget.dataState == )
      setState(() {
        hideText = false;
      });
    });

    super.initState();
  }

// void dispose(){
//   setState(() {
//     hideText = true;
//   });
//   super.dispose();
// }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            hideText
                ? Center(child: Container(child: CircularProgressIndicator()))
                // SizedBox(height: 10),
                : const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_outlined,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Error loading data",
                            style:
                                TextStyle(fontSize: 18, color: kPrimaryColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                      CancelButton()
                    ],
                  ),
          ],
        ),
      ),
    );
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

class CancelButton extends StatefulWidget {
  const CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  State<CancelButton> createState() => _CancelButtonState();
}

class _CancelButtonState extends State<CancelButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          hideText = true;
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 50,
        width: 200,
        // color: kPrimaryGradientColor,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.deepOrange, width: 2)),

        // padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: const Center(
            child: Text(
          "Back",
          style: TextStyle(fontSize: 25, color: Colors.deepOrange),
        )),
      ),
    );
  }
}
