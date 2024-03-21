import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/bottom_bar.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/router.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalVariables.init(context);
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
      onGenerateRoute: (routeSettings) => generateRoute(routeSettings),
      home: const BottomBar(),
    );
  }
}
