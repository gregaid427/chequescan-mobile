
import 'package:camera_camera/camera_camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants/app_url.dart';
import '../../core/provider/Transactionsdata.dart';

class BackscanViewModel extends ChangeNotifier {
  bool textScanning = false;

  XFile? imageFile;
  bool showNext = false;
  String scannedText = "";

  var myarr = [];
  void frontimage(String imageFile1) {
    imageFile1 = imageFile1;
    print('front image set');
    print(imageFile1);
  }

  String? imageFront;
  Future<int?> uploadImage(
      {required imagefront,
      required imageback,
      required scanAccntNo,
      required scanBankNo,
      String? user_id,
      required String amount,
      required String account_id,
        String? scancheqNo}) async {
    print("File Upload Called");
    print(imagefront);
    print(user_id);

    String? fileName1 = imagefront?.split('/').last;
    String? fileName2 = imageback?.split('/').last;
    MultipartFile? multipartFile, multipartFile1;

 //   multipartFile =
        // await MultipartFile.fromFile(imagefront!, filename: fileName1);

    multipartFile = await MultipartFile.fromFile(imagefront!, filename: fileName1);

    multipartFile1 = await MultipartFile.fromFile(imageback!, filename: fileName2);

    //final _dio = Dio(BaseOptions(connectTimeout: 50000));

    multipartFile1 =
        await MultipartFile.fromFile(imageback!, filename: fileName2);
    var request =  http.MultipartRequest(
        'POST', Uri.parse(AppUrl.uploadscandata)

    );


//     request.fields['scanImageBack'] = fileName2!;
//     request.fields['scanImageFront'] = fileName1!;
//     request.fields['scanAccntNo'] = scanAccntNo;
//     request.fields['scanBankNo'] = scanBankNo;
//     request.fields['user'] = scanBankNo;
//
//     request.fields['user_id'] = user_id!;
//
//     request.fields['issuer'] = "Issuer on cheque";
//
//     request.fields['amount'] = amount;
//     request.fields['scanChequeNo'] = scancheqNo!;
//
//
//     request.files.add(  await http.MultipartFile.fromPath(
//         'file',
//       imagefront!,
//         contentType: MediaType('Multipart', 'multipart/mixed')
//     ) );
//
//       request.files.add(  await http.MultipartFile.fromPath(
//       'file',
//         imageback!,
//
//     ));
//
//     var response = await request.send();
//     print(response.stream);
//     print(response.statusCode);
//     final res = await http.Response.fromStream(response);
//     print(res.body);
// return response.statusCode;

    var dio = Dio(BaseOptions());
    FormData data = FormData.fromMap({
      'file': [multipartFile,multipartFile1],
      "scanImageBack": fileName1,
      "scanImageFront": fileName2,
      "scanAccntNo": scanAccntNo,
      "scanBankNo": scanBankNo,
      "user": scanBankNo,
      "user_id": user_id,
      "issuer": "Issuer Name",
      "amount": amount,
      "scanChequeNo": scancheqNo
    });

    int? res = 500;
    try {
      var response = await dio.post(AppUrl.uploadscandata, data: data,
          options: Options(
           // contentType: 'application/x-www-form-urlencoded',
            contentType: 'multipart/form-data',

            //  contentType: true ? 'multipart/form-data' : 'application/json',
          //  responseType: ResponseType.plain,
            headers: {
              'Content-Type': 'multipart/form-data'
            },
          ),
          //onSendProgress: (int sent, int total) {
       // print('$sent $total');
     // }

      );
      print(response);

      print(response.statusCode);
      return response.statusCode;
    } on DioError catch (e) {
      print(e.response?.statusMessage);

      return res;
    }
  }




  void getImage(ImageSource source, context) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        notifyListeners();
        imageFile = pickedImage;
        notifyListeners();
        String value = imageFile!.path;
        notifyListeners();
        // transactionsData.setBackImagelink(value);
        Provider.of<TransactionsData>(context, listen: false)
            .setBackImagelink(value);

        // backscanModel.myarr.add(widget.frontimagevalue);
        // backscanModel.myarr.add(value);

        getRecognisedText(pickedImage);
        notifyListeners();
        print("pickedImage");
        print(pickedImage.name);
      }
    } catch (e) {
      textScanning = false;
      notifyListeners();
      imageFile = null;
      notifyListeners();
      scannedText = "Error occured while scanning";
      notifyListeners();
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    notifyListeners();
    // for (TextBlock block in recognisedText.blocks) {
    //   for (TextLine line in block.lines) {
    //     scannedText = scannedText + line.text + "\n";
    //   }
    // }
    textScanning = false;
    notifyListeners();

    showNext = true;
    notifyListeners();
  }
}
