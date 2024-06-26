import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/features/customer/cart/screens/cart_screen.dart';
import 'package:frontend/features/customer/checkout/screens/checkout_screen.dart';
import 'package:frontend/features/customer/product_details/services/product_details_services.dart';
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
  DateTime _selectedDate = DateTime.now();
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
            SizedBox(height: 10),
            //Delivery info Container
            Container(
              width: GlobalVariables.screenWidth,
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Delivery info',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: GlobalVariables.green,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: GlobalVariables.lightGrey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery address',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '288 Erie Street South Unit D, Leamington, Ontario',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: GlobalVariables.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            //Delivery Time Container
            Container(
              width: GlobalVariables.screenWidth,
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Delivery time',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: GlobalVariables.green,
                    ),
                  ),
                  GestureDetector(
                    onTap: _showDatePicker,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: GlobalVariables.lightGrey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_selectedDate.year.toString()}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.calendar_today_rounded,
                              color: GlobalVariables.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
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
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
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
                      fontSize: 16,
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
                            color: GlobalVariables.green, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: GlobalVariables.screenWidth,
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Recommended products',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: GlobalVariables.green,
                    ),
                  ),
                  SizedBox(height: 10),
                  _recommendedProducts == null
                      ? const Loader()
                      : GridView.builder(
                          controller: _recommendProductsScrollController,
                          itemCount: _recommendedProducts!.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
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
      height: 50,
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
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    ).then((value) => setState(() {
          _selectedDate = value!;
        }));
  }
}
