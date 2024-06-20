import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/cart/widgets/product_cart_item.dart';
import 'package:frontend/features/customer/checkout/screens/checkout_screen.dart';
import 'package:frontend/models/product.dart';
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
  double _subTotalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _calculateSubTotalPrice();
  }

  void _navigateToCheckoutScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      CheckoutScreen.routeName,
      arguments: true,
    );
  }

  void _removeProduct(int productId) {
    final userProvider = context.read<UserProvider>();
    setState(() {
      userProvider.user.products
          .removeWhere((product) => product.id == productId);
    });
    _calculateSubTotalPrice();
  }

  void _calculateSubTotalPrice() {
    final userProvider = context.read<UserProvider>();
    double total = 0.0;
    for (int i = 0; i < userProvider.user.products.length; i++) {
      total +=
          userProvider.user.products[i].price * userProvider.user.quantities[i];
    }
    setState(() {
      _subTotalPrice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _productsScrollController = ScrollController();
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
                  child: (userProvider.user.products.isNotEmpty)
                      ? Container(
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
                                controller: _productsScrollController,
                                itemCount: userProvider.user.products.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  Product product =
                                      userProvider.user.products[index];
                                  return ProductCartItem(
                                    productId: product.id,
                                    productName: product.name,
                                    price: product.price,
                                    imagePath: product.imageUrls.first,
                                    quantity:
                                        userProvider.user.quantities[index],
                                    limitQuantity: product.stock,
                                    onRemove: () => _removeProduct(product.id),
                                    onQuantityChanged: _calculateSubTotalPrice,
                                  );
                                },
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/vectors/vector_empty_cart.svg',
                              height: 337,
                              width: 259,
                            ),
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
                _subTotalPriceText('\$' + _subTotalPrice.toStringAsFixed(2)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: GlobalVariables.customButton(
                onTap: () => {
                      (userProvider.user.products.isNotEmpty)
                          ? _navigateToCheckoutScreen(context)
                          : {
                              IconSnackBar.show(
                                context,
                                label: 'You have no product in your cart!',
                                snackBarType: SnackBarType.fail,
                              ),
                            },
                    },
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
