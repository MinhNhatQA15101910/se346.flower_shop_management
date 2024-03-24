import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/cart/widgets/product_cart_item.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
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
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/appBG.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  color: Colors.white.withOpacity(0.5),
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
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 12.0, right: 16.0, left: 16.0, bottom: 12.0),
                      child: Column(
                        children: [
                          ProductCartItem(
                            productName: 'Product name',
                            price: 100000,
                            imagePath: 'assets/images/product1.png',
                            quantity: 1,
                          ),
                          ProductCartItem(
                            productName: 'Product name',
                            price: 100000,
                            imagePath: 'assets/images/product1.png',
                            quantity: 1,
                          ),
                          ProductCartItem(
                            productName: 'Product name',
                            price: 100000,
                            imagePath: 'assets/images/product1.png',
                            quantity: 1,
                          ),
                          ProductCartItem(
                            productName: 'Product name',
                            price: 100000,
                            imagePath: 'assets/images/product1.png',
                            quantity: 1,
                          ),
                          ProductCartItem(
                            productName: 'Product name',
                            price: 100000,
                            imagePath: 'assets/images/product1.png',
                            quantity: 1,
                          ),
                          ProductCartItem(
                            productName: 'Product name',
                            price: 100000,
                            imagePath: 'assets/images/product1.png',
                            quantity: 1,
                          ),
                          ProductCartItem(
                            productName: 'Product name',
                            price: 100000,
                            imagePath: 'assets/images/product1.png',
                            quantity: 1,
                          ),
                          ProductCartItem(
                            productName: 'Product name',
                            price: 100000,
                            imagePath: 'assets/images/product1.png',
                            quantity: 1,
                          ),
                          ProductCartItem(
                            productName: 'Product name',
                            price: 100000,
                            imagePath: 'assets/images/product1.png',
                            quantity: 1,
                          ),
                          ProductCartItem(
                            productName: 'Product name',
                            price: 100000,
                            imagePath: 'assets/images/product1.png',
                            quantity: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              //add cart item here
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
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
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: ShapeDecoration(
                    color: GlobalVariables.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _checkoutText('Process to checkout'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _checkoutText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.white,
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w400,
        ),
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
