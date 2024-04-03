import 'package:flutter/material.dart';
import 'package:frontend/features/auth/screens/welcome_screen.dart';
import 'package:frontend/features/customer/cart/screens/cart_screen.dart';
import 'package:frontend/features/customer/deals_of_day/screens/deals_of_day_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case WelcomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const WelcomeScreen(),
      );
    case DealsOfDayScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DealsOfDayScreen(),
      );
    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
