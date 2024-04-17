import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/auth/widgets/pinput_form.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _resetEmailController = TextEditingController();

  @override
  void dispose() {
    _resetEmailController.dispose();
    super.dispose();
  }

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
        key: _formKey,
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
              controller: _resetEmailController,
              decoration: InputDecoration(
                hintText: 'example@gmail.com',
                hintStyle: TextStyle(
                  color: GlobalVariables.darkGrey,
                ),
                filled: true,
                fillColor: GlobalVariables.pureWhite,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email.';
                }

                if (!EmailValidator.validate(value)) {
                  return 'Please enter a valid email.';
                }

                return null;
              },
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: GlobalVariables.standardButtonWidth,
              height: GlobalVariables.standardButtonHeight,
              child: ElevatedButton(
                onPressed: _resetPassword,
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
                    fontSize: GlobalVariables.fontSize_16,
                    color: GlobalVariables.pureWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      final authFormProvider =
          Provider.of<AuthProvider>(context, listen: false);
      authFormProvider.setForm(PinputForm());
    }
  }
}
