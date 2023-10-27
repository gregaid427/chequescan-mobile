
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key, this.title, this.color, this.backgroundColor, this.gradientbackgroundColor, this.press,
  }) : super(key: key);
  final title;
  final color;
  final backgroundColor;
  final gradientbackgroundColor;
  final Function? press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press as void Function()?,
      child: Container(
        // color: kPrimaryGradientColor,
        decoration: BoxDecoration(
            gradient: gradientbackgroundColor ,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(30)
        ),
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 75),
        child: Text(title,style: TextStyle(fontSize: 25 ,color: color),),
      ),
    );
  }
}



class RoundedButtonborder extends StatelessWidget {
  const RoundedButtonborder({
    Key? key, this.title, this.color, this.backgroundColor, this.gradientbackgroundColor, this.press,
  }) : super(key: key);
  final title;
  final color;
  final backgroundColor;
  final gradientbackgroundColor;
  final Function? press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press as void Function()?,
      child: Container(
        // color: kPrimaryGradientColor,
        decoration: BoxDecoration(
            gradient: gradientbackgroundColor ,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(30)
        ),
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 75),
        child: Text(title,style: TextStyle(fontSize: 25 ,color: color),),
      ),
    );
  }
}
class RoundedButtonborders extends StatelessWidget {
  const RoundedButtonborders({
    Key? key, this.title, this.color, this.backgroundColor, this.gradientbackgroundColor, this.press, this.borderColor,
  }) : super(key: key);
  final title;
  final color;
  final backgroundColor;
  final gradientbackgroundColor;
  final borderColor;
  final Function? press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press as void Function()?,
      child: Container(
        // color: kPrimaryGradientColor,
        decoration: BoxDecoration(
            gradient: gradientbackgroundColor ,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor,width: 2)

        ),
        padding: const EdgeInsets.symmetric(vertical: 10,),
        child: Center(child: Text(title,style: TextStyle(fontSize: 25 ,color: color),)),
      ),
    );
  }
}


