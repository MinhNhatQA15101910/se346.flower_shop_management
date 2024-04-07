import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/account/screens/account_screen.dart';
import 'package:frontend/features/customer/category/screens/category_screen.dart';
import 'package:frontend/features/customer/home/screens/home_screen.dart';
import 'package:frontend/features/customer/search/screens/search_screen.dart';

class CustomerBottomBar extends StatefulWidget {
  static const String routeName = '/customer-bottom-bar';
  const CustomerBottomBar({super.key});

  @override
  State<CustomerBottomBar> createState() => _CustomerBottomBarState();
}

class _CustomerBottomBarState extends State<CustomerBottomBar> {
  var _page = 0;
  final double _bottomBarWidth = 56;

  final _pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const SearchScreen(),
    const AccountScreen(),
  ];

  void _updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_page],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: GlobalVariables.darkGreen,
        ),
        child: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: GlobalVariables.skinColor,
          unselectedItemColor: Colors.white,
          onTap: _updatePage,
          items: [
            // Home Item
            BottomNavigationBarItem(
              icon: SizedBox(
                width: _bottomBarWidth,
                child: SvgPicture.asset(
                  'assets/vectors/vector_home.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    _page == 0 ? GlobalVariables.skinColor : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: 'Home',
            ),

            // Category Item
            BottomNavigationBarItem(
              icon: SizedBox(
                width: _bottomBarWidth,
                child: SvgPicture.asset(
                  'assets/vectors/vector_category.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    _page == 1 ? GlobalVariables.skinColor : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: 'Category',
            ),

            // Search Item
            BottomNavigationBarItem(
              icon: SizedBox(
                width: _bottomBarWidth,
                child: SvgPicture.asset(
                  'assets/vectors/vector_search.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    _page == 2 ? GlobalVariables.skinColor : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: 'Search',
            ),

            // Account Item
            BottomNavigationBarItem(
              icon: SizedBox(
                width: _bottomBarWidth,
                child: SvgPicture.asset(
                  'assets/vectors/vector_account.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    _page == 3 ? GlobalVariables.skinColor : Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
