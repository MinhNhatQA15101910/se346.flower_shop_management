import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend/common/widgets/seperator.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/features/auth/widgets/login_google_facebook.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "Sign Up",
              style: GoogleFonts.inter(
                color: GlobalVariables.darkGreen,
                fontSize: GlobalVariables.fontSize_28,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: "firstName",
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      hintText: 'First name',
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
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: FormBuilderTextField(
                    name: "lastName",
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      hintText: 'Last name',
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
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            FormBuilderTextField(
              name: 'email',
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Username',
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
                focusedBorder: InputBorder.none,
              ),
            ),
            SizedBox(height: 20),
            FormBuilderTextField(
              name: 'password',
              controller: _passwordController,
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
                focusedBorder: InputBorder.none,
              ),
              obscureText: true,
              obscuringCharacter: '*',
            ),
            SizedBox(
              height: 20.0,
            ),
            _isLoading
                ? CircularProgressIndicator()
                : SizedBox(
                    width: GlobalVariables.standardButtonWidth,
                    height: GlobalVariables.standardButtonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        _signUp();
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return GlobalVariables.green;
                          },
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: GlobalVariables.fontSize_18,
                            color: GlobalVariables.pureWhite),
                      ),
                    ),
                  ),
            Separator(
              text: Text("Continue with",
                  style: GoogleFonts.inter(
                    color: GlobalVariables.darkGreen,
                    fontSize: GlobalVariables.fontSize_16,
                    fontWeight: FontWeight.w300,
                  )),
            ),
            LoginGoogleFacebook(),
            Separator(
              text: Text("Or",
                  style: GoogleFonts.inter(
                    color: GlobalVariables.darkGreen,
                    fontSize: GlobalVariables.fontSize_24,
                    fontWeight: FontWeight.w500,
                  )),
            ),
            SizedBox(
              width: GlobalVariables.standardButtonWidth,
              height: GlobalVariables.standardButtonHeight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.pureWhite,
                  side: BorderSide(
                    width: 0.7,
                    color: GlobalVariables.green,
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Continue as a guest',
                  style: TextStyle(
                      fontSize: GlobalVariables.fontSize_18,
                      color: GlobalVariables.green),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                children: [
                  TextSpan(
                    text: "Already have an account ? ",
                  ),
                  TextSpan(
                    text: "Log In",
                    style: TextStyle(
                      fontSize: GlobalVariables.fontSize_18,
                      color: GlobalVariables.green,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signUp() {}
}
