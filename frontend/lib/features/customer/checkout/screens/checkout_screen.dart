import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/checkout/providers/shipping_info_provider.dart';
import 'package:frontend/features/customer/checkout/services/checkout_service.dart';
import 'package:frontend/features/customer/checkout/widgets/estimated_time.dart';
import 'package:frontend/features/customer/checkout/widgets/payment_method_btm_sheet.dart';
import 'package:frontend/features/customer/checkout/widgets/product_item.dart';
import 'package:frontend/features/customer/checkout/widgets/shipping_info_item.dart';
import 'package:frontend/features/customer/checkout/widgets/total_price.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/pay.dart';
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
  late final Future<PaymentConfiguration> _googlePayConfigFuture;

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

  Future<void> _createOrderFormProduct(
    int Product_id,
    DateTime estimated_receive_date,
    String province,
    String district,
    String ward,
    String detail_address,
    String receiver_name,
    String receiver_phone_number,
  ) async {
    final success = await _checkoutService.createOrderFromProduct(
        context,
        Product_id,
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
  void initState() {
    super.initState();
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('default_google_pay_config.json');
  }

  @override
  Widget build(BuildContext context) {
    final bool isNavigateFromCart =
        ModalRoute.of(context)!.settings.arguments as bool;
    final userProvider = context.watch<UserProvider>();
    final shippingInfoProvider = context.watch<ShippingInfoProvider>();
    final _productsScrollController = ScrollController();
    String districtName = shippingInfoProvider.shippingInfo.districtName;
    String wardName = shippingInfoProvider.shippingInfo.wardName;
    String detailAddress = shippingInfoProvider.shippingInfo.detailAddress;
    String receiverName = shippingInfoProvider.shippingInfo.receiverName;
    String phoneNumber = shippingInfoProvider.shippingInfo.phoneNumber;

    const _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: '99.99',
        status: PaymentItemStatus.final_price,
      )
    ];

    double _calculateSubTotalPrice() {
      double total = 0.0;
      for (int i = 0; i < userProvider.user.products.length; i++) {
        total += userProvider.user.products[i].salePrice *
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

    void onGooglePayResult(paymentResult) {
      districtName = shippingInfoProvider.shippingInfo.districtName;
      wardName = shippingInfoProvider.shippingInfo.wardName;
      detailAddress = shippingInfoProvider.shippingInfo.detailAddress;
      receiverName = shippingInfoProvider.shippingInfo.receiverName;
      phoneNumber = shippingInfoProvider.shippingInfo.phoneNumber;
      (isNavigateFromCart)
          ? _createOrderFormCart(
              _selectedDateTime,
              'TP Hồ Chí Minh',
              districtName,
              wardName,
              detailAddress,
              receiverName,
              phoneNumber,
            )
          : _createOrderFormProduct(
              GlobalVariables.productId,
              _selectedDateTime,
              'TP Hồ Chí Minh',
              districtName,
              wardName,
              detailAddress,
              receiverName,
              phoneNumber,
            );
      Navigator.of(context).pop();
      IconSnackBar.show(
        context,
        label: 'Checkout successfully',
        snackBarType: SnackBarType.success,
      );
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
                                      price: product.salePrice,
                                      imagePath: product.imageUrls.first,
                                      quantity:
                                          userProvider.user.quantities[index],
                                    );
                                  },
                                  physics: const NeverScrollableScrollPhysics(),
                                )
                              : ProductItem(
                                  productName: GlobalVariables.productName,
                                  price: GlobalVariables.productPrice,
                                  imagePath: GlobalVariables.productURL,
                                  quantity: 1,
                                ),
                        ],
                      ),
                    ),
                    _paddingText('Payment info'),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<dynamic>(
                          context: context,
                          useRootNavigator: true,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              child: PaymentMethodBottomSheet(),
                            );
                          },
                        );
                      },
                      child: GlobalVariables.customContainer(
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/img_google_pay.jpg'),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Payment methods',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      decoration: TextDecoration.none,
                                      color: GlobalVariables.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Google pay',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      decoration: TextDecoration.none,
                                      color: GlobalVariables.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.chevron_right_outlined)
                          ],
                        ),
                      ),
                    ),
                    (isNavigateFromCart)
                        ? TotalPrice(
                            subTotalPrice: _calculateSubTotalPrice(),
                            shippingPrice: 0,
                            promotionPrice: 0,
                          )
                        : TotalPrice(
                            subTotalPrice: GlobalVariables.productPrice,
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
            child: Stack(
              children: [
                GlobalVariables.customButton(
                    onTap: () {
                      if (districtName.isEmpty ||
                          wardName.isEmpty ||
                          receiverName.isEmpty ||
                          phoneNumber.isEmpty) {
                        IconSnackBar.show(
                          context,
                          label: 'Shipping address must not be empty!',
                          snackBarType: SnackBarType.fail,
                        );
                      }
                    },
                    buttonText: 'Checkout \$' +
                        _calculateSubTotalPrice().toStringAsFixed(2),
                    borderColor: GlobalVariables.black,
                    fillColor: GlobalVariables.black,
                    textColor: Colors.white),
                (districtName.isNotEmpty &&
                        wardName.isNotEmpty &&
                        receiverName.isNotEmpty &&
                        phoneNumber.isNotEmpty)
                    ? Container(
                        child: FutureBuilder<PaymentConfiguration>(
                          future: _googlePayConfigFuture,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SizedBox(
                                width: double.infinity,
                                child: GooglePayButton(
                                  paymentConfiguration: snapshot.data!,
                                  paymentItems: _paymentItems,
                                  type: GooglePayButtonType.checkout,
                                  onPaymentResult: onGooglePayResult,
                                  loadingIndicator: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
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
