import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const kButtonGradientColor = LinearGradient(
    colors: [
      Colors.pink,
      Colors.pink,
      Colors.pinkAccent,
      Colors.redAccent,
      Colors.orange,
      Colors.orangeAccent,
     // Colors.red,

      //add more colors for gradient
    ],
    begin: Alignment.bottomLeft, //begin of the gradient color
    end: Alignment.bottomRight, //end of the gradient color
    stops: [0, 0.2,0.3, 0.4,0.6, 0.8] //stops for individual colo
);

const kTitleStyle =
  TextStyle(
        color: kPrimaryColor,
        //fontWeight: FontWeight.bold,
        fontSize: 19


);

var kTitleStyle1 =
TextStyle(
    color: kPrimaryColor.withOpacity(0.8),
    fontSize: 16


);

const kHomeCardStyle1 = TextStyle(
  color: Colors.white,
//  fontFamily: 'CM Sans Serif',
  fontSize: 15.0,

);
const kHomeCardStyle2 = TextStyle(
  color: Colors.white,
 // fontFamily: 'CM Sans Serif',
  fontSize: 15.0,
  fontWeight: FontWeight.bold

);


const kPrimaryColor = Color(0xFFD47A0FF);

const kHistoryStyle = TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey

);

const kHistoryStyle1 = TextStyle(fontSize: 16,color: Colors.grey

);