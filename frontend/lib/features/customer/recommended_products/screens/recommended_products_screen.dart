import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/product_grid_view.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/cart/screens/cart_screen.dart';
import 'package:frontend/features/customer/home/services/home_service.dart';
import 'package:frontend/models/product.dart';
import 'package:google_fonts/google_fonts.dart';

class RecommendedProductsScreen extends StatefulWidget {
  static const String routeName = "/recommended-products";
  const RecommendedProductsScreen({super.key});

  @override
  State<RecommendedProductsScreen> createState() =>
      _RecommendedProductsScreenState();
}

class _RecommendedProductsScreenState extends State<RecommendedProductsScreen> {
  final _homeService = HomeService();

  final _controller = ScrollController();

  List<Product> _productList = [];

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recommended products',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  decoration: TextDecoration.none,
                  color: GlobalVariables.darkGreen,
                ),
              ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ProductGridView(
          productList: _productList,
          controller: _controller,
          hasProduct: _hasProduct,
          onRefresh: _onRefresh,
        ),
      ),
    );
  }
}
