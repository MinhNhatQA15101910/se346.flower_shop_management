import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:go_router/go_router.dart';

import "dart:developer";

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.lightGreen,
      body: GestureDetector(
        onTap: () => {context.go("/welcomescreen"), log("Welcome to welcome!")},
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/FlowerFlyWelcome.png",
                fit: BoxFit.cover,
              ),
              Text(
                "FlowerFly",
                style: TextStyle(
                  color: GlobalVariables.darkGreen,
                  fontFamily: 'Pacifico',
                  fontSize: GlobalVariables.fontSize_36,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
