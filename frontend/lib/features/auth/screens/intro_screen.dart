import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/auth/screens/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatelessWidget {
  void _navigateToWelcomeScreen(BuildContext context) {
    Navigator.of(context).pushNamed(WelcomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.lightGreen,
      body: GestureDetector(
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
                "FlowerFly!",
                style: GoogleFonts.pacifico(
                  color: GlobalVariables.darkGreen,
                  fontSize: 36,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
