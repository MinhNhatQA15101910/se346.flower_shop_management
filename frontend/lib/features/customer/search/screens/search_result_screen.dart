import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/product_grid_view.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/cart/screens/cart_screen.dart';
import 'package:frontend/features/customer/home/services/home_service.dart';
import 'package:frontend/features/customer/search/screens/search_screen.dart';
import 'package:frontend/features/customer/search/widgets/filter_btm_sheet.dart';
import 'package:frontend/features/customer/search/widgets/sort_btm_sheet.dart';
import 'package:frontend/models/product.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchResultScreen> {
  final _homeService = HomeService();

  final _controller = ScrollController();
  final _textController = TextEditingController();

  List<Product> _productList = [];

  var _currentPage = 1;
  var _hasProduct = true;
  var _isLoading = false;

  void _navigateToCartScreen() {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  void _navigateToSearchScreen() {
    Navigator.of(context).pushNamed(SearchScreen.routeName);
  }

  void _fetchAllRecommendedProducts() async {
    if (_isLoading) return;
    _isLoading = true;

    const limit = 10;

    final newProducts = await _homeService.fetchAllRecommendedProducts(
      context,
      _currentPage++,
    );

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
            const SizedBox(height: 20),
            TextField(
              onTap: _navigateToSearchScreen,
              controller: _textController,
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
                    showModalBottomSheet<dynamic>(
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return FilterBtmSheet();
                      },
                    )
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
                        useRootNavigator: true,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return const SortBtmSheet();
                        })
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
                      Text('Sort'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
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

  @override
  void dispose() {
    _textController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
