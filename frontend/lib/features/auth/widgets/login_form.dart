import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/auth/widgets/login_google_facebook.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/common/widgets/seperator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isLoadingAsGuest = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: GlobalVariables.defaultColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("Log In",
                style: GoogleFonts.inter(
                  color: GlobalVariables.darkGreen,
                  fontSize: GlobalVariables.fontSize_28,
                  fontWeight: FontWeight.w700,
                )),
            SizedBox(height: 20),
            FormBuilderTextField(
              name: 'username',
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: TextStyle(
                  color: GlobalVariables.darkGrey,
                ),
                icon: Icon(
                  Icons.person,
                  color: GlobalVariables.darkGreen,
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
            SizedBox(height: 20),
            FormBuilderTextField(
              name: 'password',
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: GlobalVariables.darkGrey,
                ),
                icon: Icon(
                  Icons.lock,
                  color: GlobalVariables.darkGreen,
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
              obscureText: true,
              obscuringCharacter: '*',
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.bottomRight,
              child: RichText(
                text: TextSpan(
                  text: 'Forgot your ',
                  style: TextStyle(
                    color: GlobalVariables.darkGreen,
                    fontSize: 16.0,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'password',
                      style: TextStyle(
                        color: GlobalVariables.darkGreen,
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : SizedBox(
                    width: GlobalVariables.standardButtonWidth,
                    height: GlobalVariables.standardButtonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        _login();
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
                        'Log In',
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
            _isLoadingAsGuest
                ? CircularProgressIndicator()
                : SizedBox(
                    width: GlobalVariables.standardButtonWidth,
                    height: GlobalVariables.standardButtonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        _loginAsGuest();
                      },
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
                    text: "Don't have an account ? ",
                  ),
                  TextSpan(
                    text: "Sign up",
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

  void _login() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      if (_usernameController.text == 'example' &&
          _passwordController.text == 'password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Successful!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid username or password!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  void _loginAsGuest() {
    setState(() {
      _isLoadingAsGuest = true;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoadingAsGuest = false;
      });
    });
  }
}
