import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/common/screens/demo_screen_1.dart';
import 'package:frontend/features/customer/category/screens/category_screen.dart';
import 'package:frontend/common/screens/demo_screen_3.dart';
import 'package:frontend/common/screens/demo_screen_4.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<StatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _page = 0;
  final double _bottomBarWidth = 56;

  final _pages = [
    const DemoScreen1(),
    const CategoryScreen(),
    const DemoScreen3(),
    const DemoScreen4(),
  ];

  void updatePage(int page) {
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
          onTap: updatePage,
          items: [
            // Home Item
            BottomNavigationBarItem(
              icon: SizedBox(
                width: _bottomBarWidth,
                child: SvgPicture.asset(
                  'android/assets/images/vector_home.svg',
                  width: 24,
                  height: 24,
                  color: _page == 0 ? GlobalVariables.skinColor : Colors.white,
                ),
              ),
              label: 'Home',
            ),

            // Category Item
            BottomNavigationBarItem(
              icon: SizedBox(
                width: _bottomBarWidth,
                child: SvgPicture.asset(
                  'android/assets/images/vector_category.svg',
                  width: 24,
                  height: 24,
                  color: _page == 1 ? GlobalVariables.skinColor : Colors.white,
                ),
              ),
              label: 'Category',
            ),

            // Search Item
            BottomNavigationBarItem(
              icon: SizedBox(
                width: _bottomBarWidth,
                child: SvgPicture.asset(
                  'android/assets/images/vector_search.svg',
                  width: 24,
                  height: 24,
                  color: _page == 2 ? GlobalVariables.skinColor : Colors.white,
                ),
              ),
              label: 'Search',
            ),

            // Account Item
            BottomNavigationBarItem(
              icon: SizedBox(
                width: _bottomBarWidth,
                child: SvgPicture.asset(
                  'android/assets/images/vector_account.svg',
                  width: 24,
                  height: 24,
                  color: _page == 3 ? GlobalVariables.skinColor : Colors.white,
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
