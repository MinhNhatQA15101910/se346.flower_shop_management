import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/loader.dart';
import 'package:frontend/features/admin/admin_drawer.dart';
import 'package:frontend/features/customer/order_management/services/order_management_service.dart';
import 'package:frontend/features/customer/order_management/widgets/order_detail_card.dart';
import 'package:frontend/models/order.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';

class OrderManagementScreen extends StatefulWidget {
  static const String routeName = "/customer-order-management";
  const OrderManagementScreen({super.key});

  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  final OrderManagementService orderManagementService =
      OrderManagementService();
  final List<String> tabbarList = [
    'All',
    'Pending',
    'In Delivery',
    'Delivered',
  ];

  final _textController = TextEditingController();
  static bool _isLoading = true;

  List<Order>? _orders;

  void _fetchAllOrders() async {
    _orders = await orderManagementService.getAllOrders(context: context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabbarList.length,
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
        drawer: AdminDrawer(),
        body: TabBarView(
          children: [
            for (int i = 0; i < tabbarList.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: _isLoading
                    ? Loader()
                    : ListView(
                        children: _orders
                                ?.where((order) =>
                                    tabbarList[i] == 'All' ||
                                    order.status.value == tabbarList[i])
                                .map((order) => OrderDetailCard(order: order))
                                .toList() ??
                            [],
                      ),
              ),
          ],
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
