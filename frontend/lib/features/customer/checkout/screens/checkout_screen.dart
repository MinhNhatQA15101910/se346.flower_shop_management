import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/checkout/providers/shipping_info_provider.dart';
import 'package:frontend/features/customer/checkout/services/checkout_service.dart';
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
  final _checkoutService = CheckoutService();
  DateTime _selectedDateTime = DateTime.now().add(Duration(days: 3));

  Future<void> _createOrderFormCart(
    DateTime estimated_receive_date,
    String province,
    String district,
    String ward,
    String detail_address,
    String receiver_name,
    String receiver_phone_number,
  ) async {
    final success = await _checkoutService.createOrderFromCart(
        context,
        estimated_receive_date,
        province,
        district,
        ward,
        detail_address,
        receiver_name,
        receiver_phone_number);
    if (success) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isNavigateFromCart =
        ModalRoute.of(context)!.settings.arguments as bool;
    final userProvider = context.watch<UserProvider>();
    final shippingInfoProvider = context.watch<ShippingInfoProvider>();
    final _productsScrollController = ScrollController();

    double _calculateSubTotalPrice() {
      double total = 0.0;
      for (int i = 0; i < userProvider.user.products.length; i++) {
        total += userProvider.user.products[i].price *
            userProvider.user.quantities[i];
      }
      return total;
    }

    String AddressDetail() {
      String city = 'TP Hồ Chí Minh';
      String district =
          shippingInfoProvider.shippingInfo.districtName.isNotEmpty
              ? ', ' + shippingInfoProvider.shippingInfo.districtName
              : '';
      String ward = shippingInfoProvider.shippingInfo.wardName.isNotEmpty
          ? ', ' + shippingInfoProvider.shippingInfo.wardName
          : '';
      String detailAddress =
          shippingInfoProvider.shippingInfo.detailAddress.isNotEmpty
              ? ', ' + shippingInfoProvider.shippingInfo.detailAddress
              : '';

      return (city + district + ward + detailAddress);
    }

    String receiverDetail() {
      String receiverName =
          shippingInfoProvider.shippingInfo.receiverName.isNotEmpty
              ? shippingInfoProvider.shippingInfo.receiverName
              : '';
      String receiverPhoneNumber =
          shippingInfoProvider.shippingInfo.phoneNumber.isNotEmpty
              ? shippingInfoProvider.shippingInfo.phoneNumber
              : '';

      if (receiverName.isNotEmpty && receiverPhoneNumber.isNotEmpty) {
        return (receiverName + ' • ' + receiverPhoneNumber);
      } else if (receiverName.isNotEmpty) {
        return receiverName;
      } else if (receiverPhoneNumber.isNotEmpty) {
        return receiverPhoneNumber;
      } else {
        return '';
      }
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
                      address: AddressDetail(),
                      receiver: receiverDetail(),
                    ),
                    _paddingText('Estimated time of delivery'),
                    EstimatedTime(
                      dateTime: _selectedDateTime,
                      onDateChanged: (newDate) {
                        setState(() {
                          _selectedDateTime = newDate;
                        });
                      },
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
                onTap: () {
                  String districtName =
                      shippingInfoProvider.shippingInfo.districtName;
                  String wardName = shippingInfoProvider.shippingInfo.wardName;
                  String detailAddress =
                      shippingInfoProvider.shippingInfo.detailAddress;
                  String receiverName =
                      shippingInfoProvider.shippingInfo.receiverName;
                  String phoneNumber =
                      shippingInfoProvider.shippingInfo.phoneNumber;
                  if (districtName.isNotEmpty &&
                      wardName.isNotEmpty &&
                      receiverName.isNotEmpty &&
                      phoneNumber.isNotEmpty) {
                    _createOrderFormCart(
                      _selectedDateTime,
                      'TP Hồ Chí Minh',
                      districtName,
                      wardName,
                      detailAddress,
                      receiverName,
                      phoneNumber,
                    );
                    Navigator.of(context).pop();
                  } else {
                    IconSnackBar.show(
                      context,
                      label: 'Shipping info must not be empty',
                      snackBarType: SnackBarType.fail,
                    );
                  }
                },
                buttonText:
                    'Checkout \$' + _calculateSubTotalPrice().toString(),
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
