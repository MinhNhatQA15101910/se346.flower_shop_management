import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginGoogleFacebook extends StatefulWidget {
  const LoginGoogleFacebook({super.key});

  @override
  _LoginGoogleFacebookState createState() => _LoginGoogleFacebookState();
}

class _LoginGoogleFacebookState extends State<LoginGoogleFacebook> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: GlobalVariables.lightGrey,
            elevation: 0,
            minimumSize: Size(GlobalVariables.subStandardButtonWidth,
                GlobalVariables.standardButtonHeight)),
        onPressed: () {
          _loginWithGoogle();
        },
        child: SvgPicture.asset(
          'assets/images/google.svg',
          width: GlobalVariables.standardIconSize,
          height: GlobalVariables.standardIconSize,
        ),
      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: GlobalVariables.lightGrey,
            elevation: 0,
            minimumSize: Size(GlobalVariables.subStandardButtonWidth,
                GlobalVariables.standardButtonHeight)),
        onPressed: () {
          _loginWithFacebook();
        },
        child: SvgPicture.asset(
          'assets/images/facebook.svg',
          width: GlobalVariables.standardIconSize,
          height: GlobalVariables.standardIconSize,
        ),
      ),
    ]);
  }

  void _loginWithGoogle() {}
  void _loginWithFacebook() {}
}
