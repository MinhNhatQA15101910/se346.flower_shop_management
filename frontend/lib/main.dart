import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/auth/screens/welcome_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/features/auth/screens/intro_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return IntroScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'welcomescreen',
          builder: (BuildContext context, GoRouterState state) {
            return const WelcomeScreen();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalVariables.init(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flowerfly',
      theme:
          ThemeData(), // Let the theme default like this my friend, we touch it later
      routerConfig: _router,
    );
  }
}
