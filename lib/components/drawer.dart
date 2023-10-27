import 'package:chequescan/constants/constants.dart';
import 'package:flutter/material.dart';

import '../pages/homescreen/home_screen.dart';


class drawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    const name = 'SP3427796544';
    const email = 'sarah@abs.com';
    // final urlImage =
    //     'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Drawer(
      child: Material(
        color: kPrimaryColor,
        child: ListView(
          children: <Widget>[
            buildHeader(
              // urlImage: urlImage,
              name: name,
              email: email,

              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeScreen(),
              )),
            ),
            Container(
              decoration: BoxDecoration(
                  // color: Colors.white
                  ),
              padding: padding,
              child: Column(
                children: [
                  // buildSearchField(),
                  Divider(color: Colors.white70),
                  // const SizedBox(height: 2),
                  buildMenuItem(
                    text: 'My Accounts',
                    icon: Icons.account_box,
                    onClicked: () => selectedItem(context, 0),
                  ),

                  buildMenuItem(
                    text: 'My Transactions',
                    icon: Icons.archive_rounded,
                    onClicked: () => selectedItem(context, 1),
                  ),


                  buildMenuItem(
                    text: 'My Earnings',
                    icon: Icons.attach_money,
                    onClicked: () => selectedItem(context, 3),
                  ),


                  buildMenuItem(
                    text: 'Change Login PIN',
                    icon: Icons.change_circle,
                    onClicked: () => selectedItem(context, 4),
                  ),

                  buildMenuItem(
                    text: 'Change Transaction PIN',
                    icon: Icons.change_circle,
                    onClicked: () => selectedItem(context, 5),
                  ),

                  buildMenuItem(
                    text: 'Report',
                    icon: Icons.file_copy,
                    onClicked: () => selectedItem(context, 5),
                  ),

                  buildMenuItem(
                    text: 'Log Out',
                    icon: Icons.power,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  Divider(color: Colors.white70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          // decoration: BoxDecoration(color: Colors.white, ),

          padding: padding.add(EdgeInsets.only(top: 60)),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(
                  "assets/images/wall.jpg",
                ),
              ),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    email,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              // Spacer(),
              // CircleAvatar(
              //   radius: 24,
              //   backgroundColor: Color.fromRGBO(30, 60, 168, 1),
              //   child: Icon(Icons.add_comment_outlined, color: Colors.white),
              // )
            ],
          ),
        ),
      );

  // Widget buildSearchField() {
  //   final color = Colors.white;
  //
  //   return TextField(
  //     style: TextStyle(color: color),
  //     decoration: InputDecoration(
  //       contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //       hintText: 'Search',
  //       hintStyle: TextStyle(color: color),
  //       prefixIcon: Icon(Icons.search, color: color),
  //       filled: true,
  //       fillColor: Colors.white12,
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //     ),
  //   );
  // }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    //final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color,fontSize: 16)),
     // hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
        break;
    }
  }
}
