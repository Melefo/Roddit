import 'package:app/controllers/Controller.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding= EdgeInsets.symmetric(horizontal: 20);

  @override

  Widget build(BuildContext context) {
      return Drawer(
        child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text("accountName"),
              accountEmail: Text("accountEmail"),
              currentAccountPicture: CircleAvatar(child: Text("P"))
          ),

          ListTile(
              leading: Icon(Icons.home),
              title: Text("Home") //Faire un Boutton
          )
        ],
      ),);
  }
}