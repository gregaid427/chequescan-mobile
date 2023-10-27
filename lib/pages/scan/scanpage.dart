import 'dart:io';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:chequescan/pages/scan/scanpage2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/ custom_appbar.dart';
import '../../components/rounded_button.dart';
import '../../constants/constants.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool textScanning = false;

  XFile? imageFile;
  bool showNext = false;
  String scannedText = "";

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

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppbar(),
            const Text('Scan Front of Cheque', style: kTitleStyle),
            Expanded(
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //     if ( imageFile != null) const CircularProgressIndicator(),
                      // if ( imageFile != null) const _showMyDialog1(),
                      if (!textScanning && imageFile == null)
                        Container(
                          width: 300,
                          height: 300,
                          child: const Image(
                            image: AssetImage('assets/images/scanimg.PNG'),
                            // height: screenHeight * 0.22,
                          ),
                        ),

                      if (!textScanning && imageFile == null)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: RoundedButton(
                                  title: 'Camera',
                                  backgroundColor: kPrimaryColor,
                                  color: Colors.white,
                                  press: () => getImage(ImageSource.camera)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: RoundedButton(
                                  title: ' Gallery ',
                                  backgroundColor: kPrimaryColor,
                                  color: Colors.white,
                                  press: () => getImage(ImageSource.gallery)),
                            ),
                          ],
                        ),

                      // if (imageFile == null)
                      //   SpinKitChasingDots(),

                      if (imageFile != null)
                        Container(
                            child: showNext != true
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 100.0),
                                    child: CircularProgressIndicator(),
                                  )
                                : Expanded(
                                    child: Image.file(File(imageFile!.path)))),
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
                          child: showNext != true
                              ? null
                              : Column(
                                  children: [
                                    RoundedButton(
                                      title: 'Continue',
                                      color: Colors.white,
                                      backgroundColor: kPrimaryColor,
                                      press: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (_) => const ScanPage2(),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 5),
                                    InkWell(
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
                                                        getImage(
                                                            ImageSource.camera);
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
                                                        getImage(ImageSource
                                                            .gallery);
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
                                      child: RoundedButton(
                                        title: ' Rescan ',
                                        color: Colors.white,
                                        backgroundColor: kPrimaryColor,
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
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
        print("pickedImage");

        print(pickedImage.name);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    // for (TextBlock block in recognisedText.blocks) {
    //   for (TextLine line in block.lines) {
    //     scannedText = scannedText + line.text + "\n";
    //   }
    // }
    textScanning = false;
    setState(() {
      showNext = true;
    });
  }

  @override
  void initState() {
    super.initState();
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
