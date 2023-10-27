import 'package:chequescan/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/shared_preference.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          InkWell(
            onTap: (){

              UserPreferences userPreferences = UserPreferences();
              userPreferences.removeUser();
            },
            child: const Icon(
              Icons.menu,
              color: kPrimaryColor,
              size: 35,
            ),
          ),
          const Image(
            image: AssetImage(
              'assets/images/logo.PNG',
            ),
            width: 120,
          )
        ],
      ),
    );
  }
}
