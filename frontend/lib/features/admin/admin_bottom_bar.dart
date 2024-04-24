import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/product_management/screens/product_management_screen.dart';

import 'package:frontend/features/customer/order_management/screens/order_management_screen.dart';

class AdminBottomBar extends StatefulWidget {
  static const String routeName = '/admin-bottom-bar';
  const AdminBottomBar({super.key});

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  var _page = 0;
  final double _bottomBarWidth = 56;

  final _pages = [
    const ProductMangementScreen(),
    const OrderManagementScreen(),
    const OrderManagementScreen(),
    const OrderManagementScreen(),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: GlobalVariables.darkGreen,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: BottomNavigationBar(
            currentIndex: _page,
            selectedItemColor: GlobalVariables.green,
            unselectedItemColor: Colors.white,
            onTap: _updatePage,
            items: [
              // Home Item
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: _bottomBarWidth,
                    child: Icon(
                      Icons.card_giftcard_outlined,
                      size: 24,
                      color: _page == 0
                          ? GlobalVariables.green
                          : GlobalVariables.darkGrey,
                    )),
                label: 'Products',
              ),

              // Category Item
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: _bottomBarWidth,
                  child: Icon(
                    Icons.category_outlined,
                    size: 24,
                    color: _page == 1
                        ? GlobalVariables.green
                        : GlobalVariables.darkGrey,
                  ),
                ),
                label: 'Category',
              ),

              // Search Item
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: _bottomBarWidth,
                  child: Icon(
                    Icons.list_alt_outlined,
                    size: 24,
                    color: _page == 2
                        ? GlobalVariables.green
                        : GlobalVariables.darkGrey,
                  ),
                ),
                label: 'Orders',
              ),

              // Account Item
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: _bottomBarWidth,
                  child: Icon(
                    Icons.analytics_outlined,
                    size: 24,
                    color: _page == 3
                        ? GlobalVariables.green
                        : GlobalVariables.darkGrey,
                  ),
                ),
                label: 'Statistics',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
