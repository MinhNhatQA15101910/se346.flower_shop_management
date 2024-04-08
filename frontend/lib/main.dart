import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/customer_bottom_bar.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/auth/screens/intro_screen.dart';
import 'package:frontend/features/customer/checkout/screens/checkout_screen.dart';
import 'package:frontend/providers/auth_form_provider.dart';
import 'package:frontend/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthFormProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalVariables.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlowerFly',
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
      home: CustomerBottomBar(),
    );
  }
}
