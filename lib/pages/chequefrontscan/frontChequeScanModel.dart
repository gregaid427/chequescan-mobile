import 'package:camera_camera/camera_camera.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../constants/api_client.dart';

import '../../constants/pagetransitions.dart';
import '../../core/provider/Transactionsdata.dart';
import '../transactions/transactions_preview_screen.dart';
import 'front_cheque_scan.dart';

class FrontChequeScanViewModel extends ChangeNotifier {
  bool textScanning = false;

  XFile? imageFile;
  bool showNext = false;
  String selectedbank = 'null';

  String scannedText = "";

  String? _chequeBank;
  String? _chequeBankNo;

  int? _accountNoLength;
  int? _BankNoLength;
  int? _chequeNoLength;

  bool? load = false;
  List? data;
  ImageSource? Source;

  void setChequeDetails(String chequeBank, int accountNoLength,
      int BankNoLength, int chequeNoLength, String bankCheqNumber) {
    _chequeBank = chequeBank;
    notifyListeners();
print(_chequeBank);
    _accountNoLength = accountNoLength;
    notifyListeners();

    _BankNoLength = BankNoLength;
    notifyListeners();

    _chequeNoLength = chequeNoLength;
    notifyListeners();

    _chequeBankNo = bankCheqNumber;
    notifyListeners();

    print('cheque details set');
  }

  void toggleSelectedBank() {
    selectedbank = 'false';
    notifyListeners();
  }

  void getImage(ImageSource source, BuildContext context) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        String value = imageFile!.path;
        Provider.of<TransactionsData>(context, listen: false)
            .setfrontImagelink(value);

        //  transactionsData.setfrontImagelink(value);
        backscanModel.frontimage(imageFile!.path);
        // backscanModel.imageFile1 = File(pickedImage!.path);
        // backscanModel.myarr.add(value);

        scanimageFile = pickedImage!.path;
        notifyListeners();

        getRecognisedText(pickedImage, context);
        print("pickedImage");

        print(pickedImage.name);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
    }
  }

  void getRecognisedText(XFile image, context) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    var values = [];
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + " ";

        values = scannedText.split(" ");
      }
    }
    print(values);
    var val;
    String? retrievedCheqNum;
    String? retrievedaccntNum;

    for (val in values) {
      //  print(val[0]);

      if (val.length == _chequeNoLength &&
          (val[val.length - 1] == '0' ||
              val[val.length - 1] == '1' ||
              val[val.length - 1] == '2' ||
              val[val.length - 1] == '3' ||
              val[val.length - 1] == '4' ||
              val[val.length - 1] == '5' ||
              val[val.length - 1] == '6' ||
              val[val.length - 1] == '7' ||
              val[val.length - 1] == '8' ||
              val[val.length - 1] == '9') &&
          (val[0] == '0' ||
              val[0] == '1' ||
              val[0] == '2' ||
              val[0] == '3' ||
              val[0] == '4' ||
              val[0] == '5' ||
              val[0] == '6' ||
              val[0] == '7' ||
              val[0] == '8' ||
              val[0] == '9')) {
        retrievedCheqNum = val;
        print('cheque No issssssssssssssss  $retrievedCheqNum');
      }

      if (val.length == _accountNoLength &&
          (val[val.length - 1] == '0' ||
              val[val.length - 1] == '1' ||
              val[val.length - 1] == '2' ||
              val[val.length - 1] == '3' ||
              val[val.length - 1] == '4' ||
              val[val.length - 1] == '5' ||
              val[val.length - 1] == '6' ||
              val[val.length - 1] == '7' ||
              val[val.length - 1] == '8' ||
              val[val.length - 1] == '9') &&
          (val[0] == '0' ||
              val[0] == '1' ||
              val[0] == '2' ||
              val[0] == '3' ||
              val[0] == '4' ||
              val[0] == '5' ||
              val[0] == '6' ||
              val[0] == '7' ||
              val[0] == '8' ||
              val[0] == '9')) {
        retrievedaccntNum = val;
        print('account No isssssssssssssss  $retrievedaccntNum');
      }
    }

    Future.delayed(const Duration(seconds: 2), () {
      if (retrievedaccntNum != null && retrievedCheqNum != null) {
        print('hurray...both numbers set');
        print(_chequeBank);


        Provider.of<TransactionsData>(context, listen: false)
            .setChequeValues(_chequeBank.toString(),retrievedaccntNum,_chequeBankNo!,retrievedCheqNum);

        showNext = true;
        notifyListeners();

        textScanning = false;
        notifyListeners();
       // alert()
      } else {
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: 'Error!',
            text: 'Please Rescan Cheque',
            loopAnimation: false,
            barrierDismissible: false,
            confirmBtnText: 'Rescan',
            cancelBtnText: 'Cancel',

            showCancelBtn: true,
            onConfirmBtnTap: () async {
              textScanning == false;
              notifyListeners();

              imageFile = null;
              notifyListeners();

              getImage(Source!, context);
              //
              // Navigator.pushReplacement(
              //    context,
              //    SlideTransition1(
              //        FrontScanPage()
              //    ),
              //  );

              print(Source);
            },
        onCancelBtnTap : () async {
          textScanning == false;
          notifyListeners();

          imageFile = null;
          notifyListeners();

          Navigator.pop(context);
        });

    }
    });

    // print(scannedText);
  }

  void apicall() async {
    ApiClient apiClient = ApiClient();
    data = await apiClient.getBanks() as List?;
    notifyListeners();

    if (data != null) {
      selectedbank = 'true';
      notifyListeners();
    }
    load = true;
    notifyListeners();
  }

  void ReadySetup() async {
    apicall();
  }

  bool getdatalength() {
    bool value = data?.length != 0 ? true : false;
    return value;
  }

  void setSource(source) {
    Source = source;
    notifyListeners();
  }
}



