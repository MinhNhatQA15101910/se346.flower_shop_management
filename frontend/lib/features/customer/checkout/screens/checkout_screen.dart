import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/checkout/widgets/estimated_time.dart';
import 'package:frontend/features/customer/checkout/widgets/product_item.dart';
import 'package:frontend/features/customer/checkout/widgets/shipping_info_item.dart';
import 'package:frontend/features/customer/checkout/widgets/total_price.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Checkout',
                style: GoogleFonts.pacifico(
                  fontSize: 24,
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
            child: Container(
              color: GlobalVariables.lightGreen,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _paddingText('Shipping info'),
                    ShippingInfoItem(
                      address:
                          '288 Erie Street South Unit D, Leamington, Ontario',
                      name: 'Nick',
                      phoneNumber: '0969696960',
                    ),
                    _paddingText('Estimated time of delivery'),
                    EstimatedTime(
                      datetime: DateTime.now(),
                    ),
                    _paddingText('Products infomation'),
                    GlobalVariables.customContainer(
                      child: Column(
                        children: [
                          ProductItem(
                            productName: 'Product 1,',
                            quantity: 12,
                            price: 1234,
                            imagePath: 'assets/images/product1.png',
                          ),
                          ProductItem(
                            productName: 'Product 1,',
                            quantity: 12,
                            price: 1234,
                            imagePath: 'assets/images/product1.png',
                          ),
                          ProductItem(
                            productName: 'Product 1,',
                            quantity: 12,
                            price: 1234,
                            imagePath: 'assets/images/product1.png',
                          ),
                        ],
                      ),
                    ),
                    TotalPrice(
                      subTotalPrice: 100,
                      shippingPrice: 5,
                      promotionPrice: 0,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
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
                  child: Center(
                    child: _checkoutText('Checkout 00,000 \$'),
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

  Widget _paddingText(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: GoogleFonts.inter(
          fontSize: 16,
          color: Colors.black,
          textStyle: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
