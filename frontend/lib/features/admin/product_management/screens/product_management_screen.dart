import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/loader.dart';
import 'package:frontend/constants/sort_options.dart';
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

  List<Product> _productsList = [];
  List<Product> _searchResults = [];

  String _keyword = '';
  SortOption _sortOption = SortOption.id;
  double _minPrice = 1;
  double _maxPrice = 99999;
  var _currentPage = 1;
  var _currentPage2 = 1;
  var _isLoading = false;
  var _hasProduct = true;
  var _isSearching = false;

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
        _productsList.addAll(newProducts);
        if (newProducts.length < limit) {
          _hasProduct = false;
        }
      }
    });
  }

  void _fetchResults() async {
    if (_isLoading) return;
    _isLoading = true;

    _isSearching = true;

    const limit = 10;

    final _sortResults = await _productManagementService.fetchResults(
      context,
      _keyword,
      _sortOption,
      _minPrice.toInt().toString(),
      _maxPrice.toInt().toString(),
      _currentPage2++,
    );

    if (!mounted) return;
    setState(() {
      _isLoading = false;
      if (_sortResults.isEmpty) {
        _hasProduct = false;
        _productsList.clear();
      } else {
        //_productList.clear();
        _productsList.addAll(_sortResults);
        if (_sortResults.length < limit) {
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
      _productsList.clear();
    });

    if (_isSearching) {
      _fetchResults();
    } else {
      _fetchAllProducts();
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchAllProducts();

    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        if (_isSearching) {
          _fetchResults();
        } else {
          _fetchAllProducts();
        }
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
                        _openFilterBottomSheet(),
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
                        _openSortBottomSheet(),
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
          _searchResults.isEmpty && _productsList.isEmpty
              ? const Center(
                  child: Column(
                  children: [
                    Image(
                      width: 200,
                      height: 200,
                      image: AssetImage('assets/images/img_no_result.png'),
                    ),
                    Text(
                      'No products found!',
                      style: TextStyle(
                        color: GlobalVariables.darkGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ))
              : Expanded(
                  child: Container(
                    color: GlobalVariables.lightGrey,
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: _productsList.isEmpty && _searchResults.isEmpty
                        ? const Loader()
                        : RefreshIndicator(
                            onRefresh: _onRefresh,
                            child: ListView.builder(
                              controller: _controller,
                              itemCount: _hasProduct
                                  ? _productsList.length + 1
                                  : _productsList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (index < _productsList.length) {
                                  return ProductManageCard(
                                    product: _productsList[index],
                                    onUpdate: _onRefresh,
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
      onSubmitted: (value) {
        setState(() {
          _keyword = value;
          _currentPage2 = 1;
          _productsList.clear();
          _fetchResults();
        });
      },
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
            setState(() {
              _keyword = '';
              _currentPage = 1;
              _productsList.clear();
              _fetchAllProducts();
            });
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

  Future<void> _openSortBottomSheet() async {
    SortOption? _selectedSortOption = await showModalBottomSheet<SortOption>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AdminProductSortBtmSheet(); // Your custom bottom sheet widget
      },
    );

    setState(() {
      if (_selectedSortOption != null) {
        _sortOption = _selectedSortOption;
        _currentPage2 = 1;
        _productsList.clear();
        _fetchResults();
      }
    });
  }

  Future<void> _openFilterBottomSheet() async {
    final result = await showModalBottomSheet<dynamic>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AdminProductFilterBtmSheet();
      },
    );

    if (result != null) {
      setState(() {
        _minPrice = result['minPrice'];
        _maxPrice = result['maxPrice'];
        _currentPage2 = 1;
        _productsList.clear();
        _fetchResults();
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
