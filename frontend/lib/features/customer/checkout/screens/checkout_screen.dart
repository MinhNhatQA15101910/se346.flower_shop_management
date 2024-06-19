import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/checkout/widgets/estimated_time.dart';
import 'package:frontend/features/customer/checkout/widgets/product_item.dart';
import 'package:frontend/features/customer/checkout/widgets/shipping_info_item.dart';
import 'package:frontend/features/customer/checkout/widgets/total_price.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  static const String routeName = '/checkout';

  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isNavigateFromCart =
        ModalRoute.of(context)!.settings.arguments as bool;
    final userProvider = context.watch<UserProvider>();
    final _productsScrollController = ScrollController();

    double _calculateSubTotalPrice() {
      double total = 0.0;
      for (int i = 0; i < userProvider.user.products.length; i++) {
        total += userProvider.user.products[i].price *
            userProvider.user.quantities[i];
      }
      return total;
    }

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
                      dateTime: DateTime.now(),
                    ),
                    _paddingText('Products information'),
                    GlobalVariables.customContainer(
                      child: Column(
                        children: [
                          (isNavigateFromCart)
                              ? ListView.builder(
                                  controller: _productsScrollController,
                                  itemCount: userProvider.user.products.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    Product product =
                                        userProvider.user.products[index];
                                    return ProductItem(
                                      productName: product.name,
                                      price: product.price,
                                      imagePath: product.imageUrls.first,
                                      quantity:
                                          userProvider.user.quantities[index],
                                    );
                                  },
                                  physics: const NeverScrollableScrollPhysics(),
                                )
                              : ProductItem(
                                  productName: 'name',
                                  price: 20,
                                  imagePath: '',
                                  quantity: 1,
                                ),
                        ],
                      ),
                    ),
                    TotalPrice(
                      subTotalPrice: _calculateSubTotalPrice(),
                      shippingPrice: 0,
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: GlobalVariables.customButton(
                onTap: () {},
                buttonText: 'Checkout 00,000 \$',
                borderColor: GlobalVariables.green,
                fillColor: GlobalVariables.green,
                textColor: Colors.white),
          ),
        ],
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
