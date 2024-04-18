import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MainAuthScreen extends StatefulWidget {
  static const String routeName = '/main-auth';
  const MainAuthScreen({super.key});

  @override
  State<MainAuthScreen> createState() => _MainAuthScreenState();
}

class _MainAuthScreenState extends State<MainAuthScreen> {
  @override
  Widget build(BuildContext context) {
    final authForm = context.watch<AuthProvider>().authForm;

    return Stack(
      children: [
        Image.asset(
          'assets/images/appBG.png',
          width: GlobalVariables.screenWidth,
          height: GlobalVariables.screenHeight,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SafeArea(
              child: authForm,
            ),
          ),
        )
      ],
    );
  }
}
