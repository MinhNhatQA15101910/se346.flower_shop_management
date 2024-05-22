import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/product_grid_view.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/cart/screens/cart_screen.dart';
import 'package:frontend/features/customer/category_products/services/category_products_service.dart';
import 'package:frontend/models/occasion.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/type.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryProductsScreen extends StatefulWidget {
  static const String routeName = "/category-products";
  const CategoryProductsScreen({
    super.key,
    this.type,
    this.occasion,
  });

  final Type? type;
  final Occasion? occasion;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final _categoryProductsService = CategoryProductsService();

  final _controller = ScrollController();

  List<Product> _productList = [];

  var _currentPage = 1;
  var _hasProduct = true;
  var _isLoading = false;

  void _navigateToCartScreen() {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  void _fetchAllCategoryProducts() async {
    if (_isLoading) return;
    _isLoading = true;

    const limit = 10;

    List<Product> newProducts = [];
    if (widget.type != null) {
      newProducts = await _categoryProductsService.fetchAllTypeProducts(
        context: context,
        page: _currentPage++,
        typeId: widget.type!.id,
      );
    } else {
      newProducts = await _categoryProductsService.fetchAllOccasionProducts(
        context: context,
        page: _currentPage++,
        occasionId: widget.occasion!.id,
      );
    }

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

  Future<void> _onRefresh() async {
    setState(() {
      _isLoading = false;
      _hasProduct = true;
      _currentPage = 1;
      _productList.clear();
    });

    _fetchAllCategoryProducts();
  }

  @override
  void initState() {
    super.initState();

    _fetchAllCategoryProducts();

    _controller.addListener(() {
      if (_controller.position.maxScrollExtent == _controller.offset) {
        _fetchAllCategoryProducts();
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
            widget.type != null
                ? 'Type - ${widget.type!.name}'
                : 'Occasion - ${widget.occasion!.name}',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              decoration: TextDecoration.none,
              color: GlobalVariables.darkGreen,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
