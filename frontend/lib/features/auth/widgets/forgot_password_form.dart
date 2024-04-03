import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController resetEmailController = TextEditingController();

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
      child: FormBuilder(
        key: formKey,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Forgot your password",
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  color: GlobalVariables.darkGreen,
                  fontWeight: FontWeight.w700,
                  fontSize: GlobalVariables.fontSize_28,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Please enter you email to reset the password",
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: GlobalVariables.fontSize_18,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            FormBuilderTextField(
              name: 'email',
              controller: resetEmailController,
              decoration: InputDecoration(
                hintText: 'Email address',
                hintStyle: TextStyle(
                  color: GlobalVariables.darkGrey,
                ),
                filled: true,
                fillColor: GlobalVariables.pureWhite,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: GlobalVariables.lightGrey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: GlobalVariables.standardButtonWidth,
              height: GlobalVariables.standardButtonHeight,
              child: ElevatedButton(
                onPressed: () {
                  resetPasword();
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
                  'Reset the password',
                  style: TextStyle(
                      fontSize: GlobalVariables.fontSize_18,
                      color: GlobalVariables.pureWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetPasword() {}
}
