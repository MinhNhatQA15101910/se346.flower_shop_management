import 'package:flutter/material.dart';
import 'package:frontend/features/admin/product_management/screens/add_product_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';

import 'package:frontend/features/admin/admin_drawer.dart';
import 'package:frontend/features/admin/product_management/widgets/product_manage_card.dart';
import 'package:frontend/features/admin/product_management/widgets/admin_product_filter_btm_sheet.dart';
import 'package:frontend/features/admin/product_management/widgets/admin_product_sort_btm_sheet.dart';

class ProductManagementScreen extends StatefulWidget {
  const ProductManagementScreen({super.key});

  @override
  State<ProductManagementScreen> createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _navigateToAddProductScreen() {
    Navigator.of(context).pushNamed(AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10),
              Text(
                'FlowerFly',
                style: GoogleFonts.pacifico(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: GlobalVariables.darkGreen,
                ),
              ),
              IconButton(
                onPressed: () => {},
                iconSize: 30,
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: GlobalVariables.darkGreen,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: AdminDrawer(),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
            child: Column(
              children: [
                _buildTextField('Enter the product keyword to search'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => {
                        showModalBottomSheet<dynamic>(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return AdminProductFilterBtmSheet();
                            })
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: GlobalVariables.darkGrey,
                        shadowColor: Colors.transparent,
                        side: const BorderSide(color: GlobalVariables.darkGrey),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.filter_alt_outlined),
                          Text('Filter'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        showModalBottomSheet<dynamic>(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return const AdminProductSortBtmSheet();
                            })
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: GlobalVariables.green,
                        shadowColor: Colors.transparent,
                        side: const BorderSide(color: GlobalVariables.green),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.sort_outlined),
                          Text('Sort'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: GlobalVariables.lightGrey,
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: ListView(
                children: [
                  ProductManageCard(),
                  ProductManageCard(),
                  ProductManageCard(),
                  ProductManageCard(),
                  ProductManageCard(),
                  ProductManageCard(),
                  ProductManageCard(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddProductScreen,
        backgroundColor: GlobalVariables.green,
        child: Icon(Icons.copy),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTextField(String hintText) {
    return TextField(
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
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          enableFeedback: false,
          onPressed: () {
            _textController.clear();
          },
          icon: const Icon(Icons.clear),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: GlobalVariables.lightGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: GlobalVariables.green),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
