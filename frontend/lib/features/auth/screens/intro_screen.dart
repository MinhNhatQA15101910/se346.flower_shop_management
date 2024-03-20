import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/auth/screens/welcome_screen.dart';

class IntroScreen extends StatelessWidget {
  void _navigateToWelcomeScreen(BuildContext context) {
    Navigator.of(context).pushNamed(WelcomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.lightGreen,
      body: InkWell(
        onTap: () => _navigateToWelcomeScreen(context),
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
