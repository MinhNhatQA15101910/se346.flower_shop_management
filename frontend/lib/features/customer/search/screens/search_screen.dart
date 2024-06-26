import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/product_grid_view.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/cart/screens/cart_screen.dart';
import 'package:frontend/features/customer/home/services/home_service.dart';
import 'package:frontend/features/customer/search/services/search_services.dart';
import 'package:frontend/features/customer/search/widgets/filter_btm_sheet.dart';
import 'package:frontend/features/customer/search/widgets/sort_btm_sheet.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/constants/sort_options.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _homeService = HomeService();
  final _searchService = SearchService();

  final _controller = ScrollController();
  final _textController = TextEditingController();

  List<Product> _productList = [];
  List<Product> _searchResults = [];

  String keyword = '';
  SortOption _sortOption = SortOption.id;
  double _minPrice = 1;
  double _maxPrice = 99999;
  var _currentPage = 1;
  var _hasProduct = true;
  var _isLoading = false;

  void _navigateToCartScreen() {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  void _fetchAllRecommendedProducts() async {
    if (_isLoading) return;
    _isLoading = true;

    const limit = 10;

    final newProducts = await _homeService.fetchAllRecommendedProducts(
      context,
      _currentPage++,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;

      if (newProducts.isEmpty) {
        _hasProduct = false;
      } else {
        _productList.addAll(newProducts);
        if (newProducts.length < limit) {
          _hasProduct = false;
        }
      }
    });
  }

  void _fetchResults() async {
    if (_isLoading) return;
    _isLoading = true;

    const limit = 10;

    final _sortResults = await _searchService.fetchResults(
      context,
      keyword,
      _sortOption,
      _minPrice.toInt().toString(),
      _maxPrice.toInt().toString(),
      _currentPage++,
    );

    if (!mounted) return;
    _productList.clear();
    setState(() {
      _isLoading = false;
      if (_sortResults.isEmpty) {
        _hasProduct = false;
      } else {
        _productList = _sortResults;
        if (_sortResults.length < limit) {
          _hasProduct = false;
        }
      }
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = false;
      _hasProduct = true;
      _currentPage = 1;
      _productList.clear();
    });

    _fetchAllRecommendedProducts();
  }

  @override
  void initState() {
    super.initState();

    _fetchAllRecommendedProducts();

    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _fetchAllRecommendedProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Text(
            'Search',
            style: GoogleFonts.pacifico(
              fontSize: 30,
              decoration: TextDecoration.none,
              color: GlobalVariables.darkGreen,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _navigateToCartScreen,
              iconSize: 30,
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: GlobalVariables.darkGreen,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              onSubmitted: (value) {
                if (value.isEmpty) return;
                setState(() {
                  keyword = value;
                  _currentPage = 1;
                  _fetchResults();
                });
              },
              style: GoogleFonts.inter(
                color: GlobalVariables.darkGrey,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                prefixIconColor: GlobalVariables.darkGrey,
                suffixIconColor: GlobalVariables.darkGrey,
                hintStyle: GoogleFonts.inter(
                  color: GlobalVariables.darkGrey,
                  fontSize: 16,
                ),
                hintText: 'Search for products',
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
                  borderSide: BorderSide(color: GlobalVariables.darkGreen),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
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
                    foregroundColor: GlobalVariables.darkGreen,
                    shadowColor: Colors.transparent,
                    side: const BorderSide(
                      color: GlobalVariables.darkGreen,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.sort_outlined),
                      Text(_sortOption.value == 'Default'
                          ? 'Sort'
                          : _sortOption.value),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _searchResults.isEmpty && _productList.isEmpty
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
                    child: ProductGridView(
                      productList: _productList,
                      controller: _controller,
                      hasProduct: _hasProduct,
                      onRefresh: _onRefresh,
                    ),
                  )
          ],
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
        return SortBtmSheet(); // Your custom bottom sheet widget
      },
    );

    setState(() {
      if (_selectedSortOption != null) {
        _sortOption = _selectedSortOption;
        _currentPage = 1;
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
        return FilterBtmSheet();
      },
    );

    if (result != null) {
      setState(() {
        _minPrice = result['minPrice'];
        _maxPrice = result['maxPrice'];
        _currentPage = 1;
        _fetchResults();
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
