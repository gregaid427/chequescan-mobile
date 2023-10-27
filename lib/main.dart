
import 'package:chequescan/pages/authentication/sign_in/signin_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'core/provider/Transactionsdata.dart';


Future<void> main() async {


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<TransactionsData>(
        create: (BuildContext context) => TransactionsData()),
  ], child: const MyApp()));

}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
int? startupStatus;

class _MyAppState extends State<MyApp> {



  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(startupStatus);

    return ViewModelBuilder<StartupModel>.reactive(
        onViewModelReady: (model) => model.ReadySetup(),
    builder: (context, model, child) => MaterialApp(
     debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    // home:OtpScreen(),
      home: SafeArea(child: LoginScreen()),
        builder: EasyLoading.init(),
    ),
      viewModelBuilder: () => StartupModel(),
    );

  }
}

class  StartupModel extends ChangeNotifier {

  ReadySetup() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      startupStatus =   prefs.getInt('verified');
      notifyListeners();
     // print(startupStatus);

  }
}
