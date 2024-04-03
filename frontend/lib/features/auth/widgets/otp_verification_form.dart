import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationForm extends StatefulWidget {
  const OtpVerificationForm({Key? key}) : super(key: key);

  @override
  _OtpVerificationFormState createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  final String resentEmail = "duyvipinhere@gmail.com";
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: GlobalVariables.screenWidth,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 20.0,
      ),
      decoration: BoxDecoration(
        color: GlobalVariables.defaultColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Check your email",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    color: GlobalVariables.darkGreen,
                    fontWeight: FontWeight.w700,
                    fontSize: GlobalVariables.fontSize_28,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "We have sent a reset email to",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: GlobalVariables.fontSize_18,
                  ),
                ),
                Text(
                  resentEmail,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: GlobalVariables.fontSize_18,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Enter 6 digit code that mentioned in the email - 60s",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: GlobalVariables.fontSize_18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Pinput(
            length: 6,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyDecorationWith(
              border: Border.all(
                color: GlobalVariables.darkGreen,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: GlobalVariables.lightGrey,
              ),
            ),
            onCompleted: (pin) => print("asdasdsadsa $pin"),
          ),
          SizedBox(height: 20.0),
          SizedBox(
            width: GlobalVariables.standardButtonWidth,
            height: GlobalVariables.standardButtonHeight,
            child: ElevatedButton(
              onPressed: () {
                _verifyCode();
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return GlobalVariables.green;
                  },
                ),
              ),
              child: Text(
                'Verify Code',
                style: TextStyle(
                    fontSize: GlobalVariables.fontSize_18,
                    color: GlobalVariables.pureWhite),
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {},
            child: Text.rich(
              TextSpan(
                text: "Haven’t got the code yet? ",
                style: TextStyle(
                  color: GlobalVariables.darkGreen,
                  fontSize: GlobalVariables.fontSize_18,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: "Resend email",
                    style: TextStyle(
                      color: GlobalVariables.darkGreen,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _verifyCode() {}
}
