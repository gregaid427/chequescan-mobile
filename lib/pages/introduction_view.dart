import 'package:flutter/material.dart';

import '../components/rounded_button.dart';
import '../constants/constants.dart';
import 'authentication/sign_in/signin_screen.dart';





class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // color: Colors.white,
            image: DecorationImage(
              image: AssetImage(
                "assets/images/intro.JPG",
              ),
              fit: BoxFit.cover,
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
           crossAxisAlignment:CrossAxisAlignment.start,
           children:  [
             const Text('welcome' ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 50 , color: Colors.white), ),
             const Divider(color: Colors.white),
             const Text('Deposit cheques in few steps' ,style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20 , color: Colors.white)),
             const SizedBox(height: 25,),
         Align(
           alignment: Alignment.center,
           child: InkWell(
             onTap: (){
               Navigator.pushReplacement(context,
                   MaterialPageRoute(builder: (context) =>  LoginScreen()));
             },
             child: const RoundedButton(title: 'Get Started', gradientbackgroundColor: kButtonGradientColor, color: Colors.white,),
           ),
         )
            ],

          ),
        ),
      ),
    );
  }
}
