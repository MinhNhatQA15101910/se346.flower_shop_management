import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/cart/widgets/product_cart_item.dart';
import 'package:frontend/features/customer/checkout/screens/checkout_screen.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _navigateToCheckoutScreen() {
    Navigator.of(context).pushNamed(CheckoutScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cart',
                style: GoogleFonts.pacifico(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: GlobalVariables.darkGreen,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  child: Container(
                    color: GlobalVariables.lightGreen,
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 12.0,
                      left: 16.0,
                      right: 16.0,
                      bottom: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                          itemCount: userProvider.user.products.length,
                          itemBuilder: (context, index) {
                            final product = userProvider.user.products[index];
                            final currentQuantity =
                                userProvider.user.quantities[index];
                            return ProductCartItem(
                              productName: product.name,
                              price: product.price,
                              imagePath: product.imageUrls.first,
                              quantity: currentQuantity,
                              limitQuantity: product.stock,
                            );
                          },
                        ),
                        ProductCartItem(
                          productName: 'Product name',
                          price: 100000,
                          imagePath: 'assets/images/product1.png',
                          quantity: 1,
                          limitQuantity: 5,
                        ),
                        ProductCartItem(
                          productName: 'Product name',
                          price: 100000,
                          imagePath: 'assets/images/product1.png',
                          quantity: 1,
                          limitQuantity: 5,
                        ),
                        ProductCartItem(
                          productName: 'Product name',
                          price: 100000,
                          imagePath: 'assets/images/product1.png',
                          quantity: 1,
                          limitQuantity: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 16,
                      color: GlobalVariables.lightGreen,
                    )
                  ],
                ),
              ],
              //add cart item here
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _subTotalText('Subtotal price'),
                _subTotalPriceText('100.000 ₫'),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: GlobalVariables.customButton(
                onTap: _navigateToCheckoutScreen,
                buttonText: 'Process to checkout',
                borderColor: GlobalVariables.green,
                fillColor: GlobalVariables.green,
                textColor: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _subTotalText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.black,
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _subTotalPriceText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.black,
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
