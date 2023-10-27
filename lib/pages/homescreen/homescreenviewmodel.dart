

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/api_client.dart';

class HomeScreeViewModel extends ChangeNotifier {


  static String Trimstring(string) {
   if (string == null) {
     return "";
   }
    if (string.length < 16) {
      return string;
    } else {
      String text = string.substring(0, 16) + '.';
      return text;
    }
  }

 static List<Map<String, dynamic>> historyItems = [
   {
     "issuer": "ID ventures",
     "account": "2467 4534 4532 6654",
     "amount": "2500,000.00",
   },
   {
     "issuer": "Greory Aidoo Richardson",
     "account": "2467 4534 4532 6654",
     "amount": "1,025.00",
   },
   {
     "issuer": "Yestech Ghana Incorporated",
     "account": "2467 4534 4532 6654",
     "amount": "1,800,025.00",
   },
   {
     "issuer": "Yestech Ghana Incorporated",
     "account": "2467 4534 4532 6654",
     "amount": "1,800,025.00",
   },
   {
     "issuer": "Yestech Ghana Incorporated",
     "account": "2467 4534 4532 6654",
     "amount": "1,800,025.00",
   },
 ];


}


