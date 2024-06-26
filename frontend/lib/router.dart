import 'package:flutter/material.dart';
import 'package:frontend/features/admin/admin_bottom_bar.dart';
import 'package:frontend/features/admin/product_management/screens/add_product_screen.dart';
import 'package:frontend/features/customer/category_products/screens/category_products_screen.dart';
import 'package:frontend/features/customer/customer_bottom_bar.dart';
import 'package:frontend/features/auth/screens/main_auth_screen.dart';
import 'package:frontend/features/auth/screens/welcome_screen.dart';
import 'package:frontend/features/customer/cart/screens/cart_screen.dart';
import 'package:frontend/features/customer/deals_of_day/screens/deals_of_day_screen.dart';
import 'package:frontend/features/customer/order_details/screens/order_details_screen.dart';
import 'package:frontend/features/customer/order_management/screens/order_management_screen.dart';
import 'package:frontend/features/customer/product_details/screens/product_details_screen.dart';
import 'package:frontend/features/customer/checkout/screens/checkout_screen.dart';
import 'package:frontend/features/customer/rating/screens/rating_screen.dart';
import 'package:frontend/features/customer/recommended_products/screens/recommended_products_screen.dart';
import 'package:frontend/models/occasion.dart';
import 'package:frontend/models/type.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case WelcomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const WelcomeScreen(),
      );
    case MainAuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainAuthScreen(),
      );
    case CustomerBottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CustomerBottomBar(),
      );
    case DealsOfDayScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => DealsOfDayScreen(),
      );
    case RecommendedProductsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => RecommendedProductsScreen(),
      );
    case CategoryProductsScreen.routeName:
      var category = routeSettings.arguments;
      if (category is Type?) {
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryProductsScreen(
            type: category,
          ),
        );
      } else {
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryProductsScreen(
            occasion: category as Occasion?,
          ),
        );
      }
    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CartScreen(),
      );
    case CheckoutScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CheckoutScreen(),
      );
    case ProductDetailsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProductDetailsScreen(),
      );
    case AdminBottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminBottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );
    case OrderDetailsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrderDetailsScreen(),
      );
    case OrderManagementScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrderManagementScreen(),
      );
    case RatingScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RatingScreen(),
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
