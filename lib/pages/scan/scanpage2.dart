import 'dart:io';

//import 'package:chequescan/pages/transactions/transactions_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/rounded_button.dart';
import '../../constants/constants.dart';
import 'package:http/http.dart' as http;

File? imageFile1;
File? imageFile2;

XFile? imageFile;

class ScanPage2 extends StatefulWidget {
  const ScanPage2({Key? key}) : super(key: key);

  @override
  State<ScanPage2> createState() => _ScanPage2State();
}

class _ScanPage2State extends State<ScanPage2> {
  bool textScanning = false;

  bool showNext = false;
  String scannedText = "";

  Future<void> uploadImage() async {
    String fileName = imageFile1!.path.split('/').last;
    String fileName2 = "123"+imageFile1!.path.split('/').last;

    MultipartFile? multipartFile, multipartFile1 ;


    for(var i = 0 ; i < 2 ; i++){
       multipartFile = await MultipartFile.fromFile(imageFile1!.path, filename: fileName) ;

    }
    multipartFile = await MultipartFile.fromFile(imageFile1!.path, filename: fileName) ;
    multipartFile1 = await MultipartFile.fromFile(imageFile1!.path, filename: 'zzzz'+fileName) ;


    var dio = Dio();
    FormData data = FormData.fromMap({
      'file': [multipartFile,multipartFile1] ,
   //   'file': await MultipartFile.fromFile(imageFile1!.path, filename: fileName2),

      "scanImageBack": fileName,
      "scanImageFront": fileName,
      "scanAccntNo": "292547234753945345-34",
      "scanBankNo": "292547234753945345-34",
      "scanChequeNo": "1"
    });

    var response = await dio.post('http://192.168.43.53:5000/api/scan/upload',
        data: data, onSendProgress: (int sent, int total) {
      print('$sent $total');
    });
    print(response.data);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Text Recognition example"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (textScanning) const CircularProgressIndicator(),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (imageFile != null) Image.file(File(imageFile!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.image,
                                  size: 30,
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    scannedText,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  child: showNext != true
                      ? null
                      : RoundedButton(
                          title: 'Continue',
                          color: Colors.white,
                          backgroundColor: kPrimaryColor,
                          press: () {
                            uploadImage();
                            // Navigator.push(
                            //   context,
                            //   CupertinoPageRoute(
                            //     builder: (_) => const TransactionsPreview(),
                            //   ),
                            // );
                          },
                        ),
                )
              ],
            )),
      )),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;

        imageFile1 = File(pickedImage!.path);
        uploadImage();
        // uploadImage1('ffffff',imageFile1!.path);

        setState(() {
          imageFile1 = File(pickedImage!.path);
          imageFile = pickedImage;
        });
        getRecognisedText(pickedImage);
        print("pickedImage");
        print(pickedImage.name);
      }
    } catch (e) {
      textScanning = false;
      imageFile1 = null;
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
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
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

class MyApp1 extends StatelessWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Upload'),
        ),
        body: Center(
          child: Container(
            child: TextButton(
              onPressed: () {
                //  uploadImage1('image', File('assets/testimage.png'));
              },
              child: Text('Upload'),
            ),
          ),
        ),
      ),
    );
  }
}

uploadImage1(String title, String file) async {
  http.MultipartRequest request = new http.MultipartRequest(
      "POST", Uri.parse('http://192.168.43.53:5000/api/scan/upload'));

  http.MultipartFile multipartFile =
      await http.MultipartFile.fromPath('file', imageFile1!.path);

  request.files.add(multipartFile);

  http.StreamedResponse response = await request.send();

  print(response.statusCode);

//
//   var request = http.MultipartRequest("POST",Uri.parse('http://192.168.43.53:5000/api/scan/upload'));
// print(file);
//
//   // request.fields['title'] = "dummyImage";
//   // request.headers['Authorization'] = "Client-ID " +"f7........";
//
//   var picture = http.MultipartFile.fromBytes('image', (await rootBundle.load(file)).buffer.asUint8List(),
//       filename: 'logo.PNG');
//
//   request.files.add(picture);
//
//   var response = await request.send();
//
//   var responseData = await response.stream.toBytes();
//
//   var result = String.fromCharCodes(responseData);
//
//   print(result);
// print('sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
}
