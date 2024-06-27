import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/category_management/screens/category_management_screen.dart';
import 'package:frontend/features/admin/product_management/screens/product_management_screen.dart';
import 'package:frontend/features/admin/statistic/screens/statistic_screen.dart';
import 'package:frontend/common/features/order_management/screens/order_management_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AdminBottomBar extends StatefulWidget {
  static const String routeName = '/admin-bottom-bar';
  const AdminBottomBar({super.key});

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ProductManagementScreen(),
    const CategoryManagementScreen(),
    const OrderManagementScreen(),
    const StatisticScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              GlobalVariables.darkGreen,
              GlobalVariables.green,
            ],
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black,
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GNav(
              gap: 6,
              backgroundColor: Colors.transparent,
              color: Colors.white,
              activeColor: GlobalVariables.darkGreen,
              tabBackgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [
                GButton(
                  icon: Icons.card_giftcard_outlined,
                  text: 'Products',
                ),
                GButton(
                  icon: Icons.category_outlined,
                  text: 'Category',
                ),
                GButton(
                  icon: Icons.list_alt_outlined,
                  text: 'Orders',
                ),
                GButton(
                  icon: Icons.analytics_outlined,
                  text: 'Statistics',
                ),
              ]),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
