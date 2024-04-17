import 'package:flutter/material.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MainAuthScreen extends StatelessWidget {
  static const String routeName = '/main-auth';
  const MainAuthScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final authForm = context.watch<AuthProvider>().authForm;

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
                  SizedBox(
                    height: 40,
                  ),
                  authForm,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
