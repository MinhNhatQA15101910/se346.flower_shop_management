import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/auth/widgets/login_form.dart';
import 'package:frontend/features/auth/widgets/otp_verification_form.dart';
import 'package:frontend/features/auth/widgets/sign_up_form.dart';
import 'package:google_fonts/google_fonts.dart';

class MainAuthScreen extends StatelessWidget {
  const MainAuthScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/appBG.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Flowerly",
                    style: GoogleFonts.pacifico(
                      color: GlobalVariables.darkGreen,
                      fontSize: GlobalVariables.fontSize_48,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  // here's where the form transitions come in okay, not integrate navigation yet
                  OtpVerificationForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
