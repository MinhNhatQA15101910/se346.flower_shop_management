import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/features/customer/cart/screens/cart_screen.dart';
import 'package:frontend/features/customer/checkout/screens/checkout_screen.dart';
import 'package:frontend/features/customer/product_details/services/product_details_services.dart';
import 'package:frontend/features/customer/rating/screens/rating_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/common/widgets/loader.dart';
import 'package:frontend/common/widgets/single_product_card.dart';

import 'package:frontend/models/product.dart';
import 'package:frontend/features/customer/product_details/widgets/product_details_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _productDetailService = ProductDetailService();

  final _recommendProductsScrollController = ScrollController();

  bool _isReadMore = false;
  List<Product>? _recommendedProducts;
  late Product _product;

  void _navigateToCartScreen() {
    Navigator.of(context).pushNamed(CartScreen.routeName);
  }

  void _navigateToCheckoutScreen() {
    Navigator.of(context).pushNamed(
      CheckoutScreen.routeName,
      arguments: false,
    );
  }

  void _navigateToRatingScreen() {
    Navigator.of(context).pushNamed(RatingScreen.routeName);
  }

  void _fetchRecommendedProductsInFirstPage() async {
    List<Product> newProducts =
        await _productDetailService.fetchAllRecommendedProducts(
      context,
      1,
    );

    setState(() {
      _recommendedProducts = newProducts;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRecommendedProductsInFirstPage();
  }

  Future<void> _addToCart(int productId) async {
    final success = await _productDetailService.addToCart(context, productId);
    if (success) {
      IconSnackBar.show(
        context,
        label: 'Add product to card successfully',
        snackBarType: SnackBarType.success,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _product = ModalRoute.of(context)!.settings.arguments as Product;
    //initState();
    return Scaffold(
      backgroundColor: GlobalVariables.lightGrey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            actions: [
              IconButton(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                onPressed: _navigateToCartScreen,
                iconSize: 30,
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: GlobalVariables.darkGreen,
                ),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductDetailsWidget(product: _product),

            SizedBox(height: 8),
            // Product detail Container
            Container(
              width: GlobalVariables.screenWidth,
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Product details',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: GlobalVariables.green,
                    ),
                  ),
                  _buildProductDetail('Size', _product.size.toString()),
                  _buildProductDetail('Weight:', _product.weight.toString()),
                  _buildProductDetail('Color:', _product.color),
                  _buildProductDetail('Material:', _product.material),

                  SizedBox(height: 12),
                  // Read more
                  Text(
                    _product.detailDescription,
                    maxLines: _isReadMore ? null : 3,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),

                  Center(
                    child: TextButton(
                      onPressed: () => setState(() {
                        _isReadMore = !_isReadMore;
                      }),
                      child: Text(
                        _isReadMore ? 'Read less' : 'Read more',
                        style: GoogleFonts.inter(
                            color: GlobalVariables.green, fontSize: 14),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        GlobalVariables.productId = _product.id;
                        GlobalVariables.productName = _product.name;
                        GlobalVariables.productURL = _product.imageUrls.first;
                        GlobalVariables.productPrice = _product.salePrice;

                        _navigateToRatingScreen();
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: GlobalVariables.green,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: Text(
                            'Rate',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 8,
              color: GlobalVariables.lightGrey,
            ),
            Container(
              width: GlobalVariables.screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Recommended products',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: GlobalVariables.green,
                    ),
                  ),
                  SizedBox(height: 8),
                  _recommendedProducts == null
                      ? const Loader()
                      : GridView.builder(
                          controller: _recommendProductsScrollController,
                          itemCount: _recommendedProducts!.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 3 / 4,
                          ),
                          itemBuilder: (context, index) {
                            return SingleProductCard(
                              product: _recommendedProducts![index],
                            );
                          },
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: GlobalVariables.lightGrey,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GlobalVariables.customButton(
                buttonText: 'Add to cart',
                borderColor: GlobalVariables.green,
                fillColor: Colors.white,
                textColor: GlobalVariables.green,
                onTap: () {
                  _addToCart(_product.id);
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: GlobalVariables.customButton(
                buttonText: 'Buy now',
                borderColor: GlobalVariables.green,
                fillColor: GlobalVariables.green,
                textColor: Colors.white,
                onTap: () {
                  GlobalVariables.productId = _product.id;
                  GlobalVariables.productName = _product.name;
                  GlobalVariables.productURL = _product.imageUrls.first;
                  GlobalVariables.productPrice = _product.salePrice;

                  _navigateToCheckoutScreen();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductDetail(String title, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: GlobalVariables.lightGrey,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
