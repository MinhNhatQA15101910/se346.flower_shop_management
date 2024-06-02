import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/account/screens/account_screen.dart';
import 'package:frontend/features/customer/category/screens/category_screen.dart';
import 'package:frontend/features/customer/home/screens/home_screen.dart';
import 'package:frontend/features/customer/search/screens/search_result_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomerBottomBar extends StatefulWidget {
  static const String routeName = '/customer-bottom-bar';
  const CustomerBottomBar({super.key});

  @override
  State<CustomerBottomBar> createState() => _CustomerBottomBarState();
}

class _CustomerBottomBarState extends State<CustomerBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const CategoryScreen(),
    const SearchResultScreen(),
    const AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _pages.insert(
      0,
      HomeScreen(
        changeToCategoryScreen: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: GlobalVariables.darkGreen,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: GNav(
            gap: 6,
            backgroundColor: GlobalVariables.darkGreen,
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
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.category,
                text: 'Category',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.account_circle,
                text: 'Account',
              )
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
