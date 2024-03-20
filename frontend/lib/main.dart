import 'package:flutter/material.dart';
import 'package:frontend/common/screens/product_list_screen.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/auth/screens/intro_screen.dart';
import 'package:frontend/features/customer/home/screens/home_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flowerfly',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.defaultColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.green,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: GlobalVariables.darkGreen,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
