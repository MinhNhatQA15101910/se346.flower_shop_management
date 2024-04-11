import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/features/customer/cart/screens/cart_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';

//Widget imports

class OrderManagementScreen extends StatefulWidget {
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  final List<String> tabbarList = [
    'All',
    'Pending',
    'In Delivery',
    'Delivered',
    'Cancelled'
  ];

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: GlobalVariables.screenWidth * 0.6,
                    child: TextField(
                      controller: _textController,
                      style: GoogleFonts.inter(
                        color: GlobalVariables.darkGrey,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        prefixIconColor: GlobalVariables.darkGrey,
                        suffixIconColor: GlobalVariables.darkGrey,
                        hintStyle: GoogleFonts.inter(
                          color: GlobalVariables.darkGrey,
                          fontSize: 16,
                        ),
                        hintText: 'Enter the product keyword to search',
                        prefixIcon: const Icon(Icons.search),
                        // suffixIcon: IconButton(
                        //   enableFeedback: false,
                        //   onPressed: () {
                        //     _textController.clear();
                        //   },
                        //   icon: const Icon(Icons.clear),
                        // ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: GlobalVariables.lightGrey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: GlobalVariables.darkGreen),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottom: _buildTabbar(tabbarList),
        ),
        drawer: Drawer(
          child: Container(
            width: GlobalVariables.screenWidth * 0.7,
            child: ListView(
              children: [],
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
                child: const Text('Go to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildTabbar(List<String> tabbarList) {
    return TabBar(
      tabAlignment: TabAlignment.center,
      isScrollable: true,
      unselectedLabelColor: GlobalVariables.darkGrey,
      labelColor: GlobalVariables.green,
      tabs: [
        for (final tab in tabbarList)
          Container(
            width: GlobalVariables.screenWidth * 0.2,
            child: Tab(
              child: Text(tab),
            ),
          ),
      ],
    );
  }
}
