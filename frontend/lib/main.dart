import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/admin_bottom_bar.dart';
import 'package:frontend/features/auth/screens/intro_screen.dart';
import 'package:frontend/features/auth/screens/main_auth_screen.dart';
import 'package:frontend/features/auth/services/auth_service.dart';
import 'package:frontend/features/customer/customer_bottom_bar.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authService = AuthService();

  bool _isFirstLaunch = false;

  void getFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstLaunch = prefs.getBool('is-first-launch');

    if (isFirstLaunch == null || isFirstLaunch) {
      setState(() {
        _isFirstLaunch = true;
      });
    } else {
      setState(() {
        _isFirstLaunch = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getFirstLaunch();
    _authService.getUserData(context);
  }

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
      home: AdminBottomBar(),
      home: _isFirstLaunch
          ? IntroScreen()
          : Provider.of<UserProvider>(context).user.token.isNotEmpty
              ? Provider.of<UserProvider>(context).user.role == 'admin'
                  ? AdminBottomBar()
                  : CustomerBottomBar()
              : MainAuthScreen(),
    );
  }
}
