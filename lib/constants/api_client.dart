import 'dart:convert';
import 'package:chequescan/constants/shared_preference.dart';
import 'package:chequescan/constants/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_url.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final Dio _dio =
      Dio(BaseOptions(connectTimeout: Duration(milliseconds: 10000)));

  AppUrl appUrl = AppUrl();

  Future<dynamic> registerUser(Map userdata, BuildContext context) async {
    final http.Response response = await http.post(Uri.parse(AppUrl.register),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userdata));

    print(response.body);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      print('sign up successfully');
      return response;
    }
    if (response.statusCode != 200) {
      EasyLoading.dismiss();
      print('error signing up');
      return response;
    }
  }

  Future<dynamic> login(
      String email, String password, BuildContext context) async {
    try {
      Response response = await _dio.post(
        AppUrl.login,
        data: {
          'email': email,
          'password': password,
        },

        // queryParameters: {'apikey': ApiSecret.apiKey},
      );
      // print(response.st);
      return response;
    } on DioException catch (e) {
      print(e);

      print("App internal Error");
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: Unable to log in'),
        backgroundColor: Colors.red.shade300,
      ));
      return e.response!.data;
      // return 'conn err';
    }
  }

  Future<dynamic> getUserProfileData(String accessToken, String userId) async {
    try {
      Response response = await _dio.get(
        AppUrl.getuserprofilebyid + '$userId',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
//////
//       final Map<String, dynamic> responseData = json.decode(response.data);
//       var userData = responseData['data'];
//       User authUser = User.fromJson(userData);
//       //persist data
//       final UserPreferences _userPreferences = UserPreferences();
//       _userPreferences.saveUser(authUser);

      print('response');
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> updateUserProfile({
    required String accessToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      Response response = await _dio.put(
        'https://api.loginradius.com/identity/v2/auth/account',
        data: data,
        //   queryParameters: {'apikey': ApiSecret.apiKey},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> logout(String accessToken) async {
    try {
      Response response = await _dio.get(
        'https://api.loginradius.com/identity/v2/auth/access_token/InValidate',
        //    queryParameters: {'apikey': ApiSecret.apiKey},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<List?> getUserLinkedaccount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userid = prefs.getString("user_id");
    http.Response response;
    response = await http.get(Uri.parse(AppUrl.userlinkedaccount + userid!));
    if (response.statusCode == 200) {
      dynamic serverD = json.decode(response.body);
      dynamic data = serverD?['data'];
      print(serverD?['data']);
      return data as List;
    }
    // else{
    //   return response.statusCode;
    // }
  }

  Future<List?> getBanks() async {
    http.Response response;
    response = await http.get(Uri.parse(AppUrl.getbanks));
    if (response.statusCode == 200) {
      dynamic serverD = json.decode(response.body);
      dynamic data = serverD?['data'];
      print(serverD?['data']);
      return data as List;
    }
    // else{
    //   return response.statusCode;
    // }
  }

  Future<List?> getTransactions() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userid = prefs.getString("user_id");
    http.Response response;
    response = await http.get(Uri.parse(AppUrl.accountTransactions + userid!));
    if (response.statusCode == 200) {
      dynamic serverD = json.decode(response.body);
      dynamic data = serverD?['data'];
      print(serverD?['data']);
      return data as List;
    }
    // else{
    // //  return 'error';
    // }
  }

  Future<dynamic> ResetOTP(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userid = prefs.getString("user_id");
    try {
      Response response = await _dio.post(
        AppUrl.otpReset,
        data: {'user_id': userid},

        // queryParameters: {'apikey': ApiSecret.apiKey},
      );
      print(response.statusCode);

      return response;
    } on DioError catch (e) {
      print("App internal Error");

      return e;
      // return 'conn err';
    }
  }

  Future<dynamic> UpdateVerification(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userid = prefs.getString("user_id");
    print(userid);
    try {
      Response response = await _dio.post(
        AppUrl.otpVerify,
        data: {'user_id': userid},

        // queryParameters: {'apikey': ApiSecret.apiKey},
      );
      print(response.statusCode);

      return response.statusCode;
    } on DioError catch (e) {
      print("App internal Error");

      return e;
      // return 'conn err';
    }
  }
}
// http.Response response;
// final SharedPreferences prefs = await SharedPreferences.getInstance();
// String? userid = prefs.getString("user_id");
// response = await http.get(Uri.parse("http://192.168.43.53:5000/api/transactions/$userid"));
// List? data;
// if(response.statusCode == 200){
// var serverData = json.decode(response.body);
// data = serverData?['data'];
// print(data);
// return data;
// }
// else{
// return 'error';
// }

//
//
//   Future<GeneralResponseModel> makeGetRequests(String url,
//       {dynamic queryParams}) async {
//     print(url);
//     // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//     //     (HttpClient client) {
//     //   client.badCertificateCallback =
//     //       (X509Certificate cert, String host, int port) => true;
//     //   return client;
//     // };
//
//     GeneralResponseModel responseModel = GeneralResponseModel(code: 90, msg: '');
//
//     await _dio.get( url , queryParameters: queryParams,)
//         .then((response) {
//       responseModel = _getProperResponseFromServer(response);
//     }).catchError((error) {
//       print(error);
//      // responseModel =  GeneralResponseModel(code: 90, msg: '');
//       responseModel.msg =  'An Error Occured. Please try again later';
//       responseModel.code = Endpoints.ConnErrCode;
//     });
//
//     return responseModel;
//   }
//
// }
//
//
// class GeneralResponseModel {
//   String msg;
//   int code;
//   dynamic responseObject;
//
//   // GeneralResponseModel();
//
//   GeneralResponseModel({required this.code, required this.msg});
// }
