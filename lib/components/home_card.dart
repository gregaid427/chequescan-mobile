import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class HomeCard extends StatelessWidget {
  const HomeCard(
      {Key? key,
      this.accountType,
      this.accountNumber,
      this.scanneedNumber,
      this.TotalscanneedAmount})
      : super(key: key);

  final accountType, accountNumber, scanneedNumber, TotalscanneedAmount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 140,
        width: 320,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.orange),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Account Type:',
                      style: kHomeCardStyle1,
                    ),
                    Text(
                      accountType,
                      style: kHomeCardStyle2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Account Number:',
                      style: kHomeCardStyle1,
                    ),
                    Text(
                      accountNumber,
                      style: kHomeCardStyle2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Number of Cheque Scanned:',
                      style: kHomeCardStyle1,
                    ),
                    Text(
                      scanneedNumber,
                      style: kHomeCardStyle2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Scanned Cheque:',
                      style: kHomeCardStyle1,
                    ),
                    Text(
                      'GHS ' + TotalscanneedAmount,
                      style: kHomeCardStyle2,
                    ),
                  ],
                )
              ],
            ),
            const Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    child: Text(
                  'Unlink Acount',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 15),
                )))
          ],
        ),
      ),
    );
  }
}



