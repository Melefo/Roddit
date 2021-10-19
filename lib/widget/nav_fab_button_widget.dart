import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

class NavigationFabButtonWidget extends StatelessWidget {

  final IconData buttonIcon;

  NavigationFabButtonWidget({required this.buttonIcon}) {
  }
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(child: Icon(buttonIcon), onPressed: () {});
  }
}