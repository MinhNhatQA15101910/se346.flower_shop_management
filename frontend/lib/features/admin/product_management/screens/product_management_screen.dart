import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/loader.dart';
import 'package:frontend/features/admin/product_management/screens/add_product_screen.dart';
import 'package:frontend/features/admin/product_management/services/product_management_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/models/product.dart';

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
  final _controller = ScrollController();
  final _productManagementService = ProductManagementService();

  List<Product> productsList = [];
  var _currentPage = 1;
  var _isLoading = false;
  var _hasProduct = true;

  void _fetchAllProducts() async {
    if (_isLoading) return;
    _isLoading = true;

    const limit = 10;

    final newProducts = await _productManagementService.fetchAllProducts(
      context,
      _currentPage++,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;

      if (newProducts.isEmpty) {
        _hasProduct = false;
      } else {
        productsList.addAll(newProducts);
        if (newProducts.length < limit) {
          _hasProduct = false;
        }
      }
    });
  }

  void _navigateToAddProductScreen() {
    Navigator.of(context).pushNamed(AddProductScreen.routeName);
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = false;
      _hasProduct = true;
      _currentPage = 1;
      productsList.clear();
    });

    _fetchAllProducts();
  }

  @override
  void initState() {
    super.initState();

    _fetchAllProducts();

    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _fetchAllProducts();
      }
    });
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
              child: productsList.isEmpty
                  ? const Loader()
                  : RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        controller: _controller,
                        itemCount: _hasProduct
                            ? productsList.length + 1
                            : productsList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (index < productsList.length) {
                            return ProductManageCard(
                              product: productsList[index],
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: _hasProduct
                                  ? Loader()
                                  : Center(
                                      child: Text(
                                        'No more product to load.',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: GlobalVariables.green,
                                        ),
                                      ),
                                    ),
                            );
                          }
                        },
                        physics: const BouncingScrollPhysics(),
                      ),
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

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
