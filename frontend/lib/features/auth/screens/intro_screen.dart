import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/auth/screens/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget {
  void _navigateToWelcomeScreen(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is-first-launch', false);

    Navigator.of(context).pushNamed(WelcomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToWelcomeScreen(context),
      child: Scaffold(
        backgroundColor: GlobalVariables.lightGreen,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
