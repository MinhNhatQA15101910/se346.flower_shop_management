import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';

class SetNewPasswordForm extends StatefulWidget {
  const SetNewPasswordForm({Key? key}) : super(key: key);

  @override
  _SetNewPasswordFormState createState() => _SetNewPasswordFormState();
}

class _SetNewPasswordFormState extends State<SetNewPasswordForm> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                "Set a new password",
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
                "Create a new password. Ensure it differences from the previous one.",
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: GlobalVariables.fontSize_18,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            FormBuilderTextField(
              name: 'password',
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
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
            SizedBox(height: 10),
            FormBuilderTextField(
              name: 'confirmPassword',
              controller: confirmPasswordController,
              decoration: InputDecoration(
                hintText: 'Confirm password',
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
                  updatePassword();
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
                  'Update password',
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

  void updatePassword() {}
}
