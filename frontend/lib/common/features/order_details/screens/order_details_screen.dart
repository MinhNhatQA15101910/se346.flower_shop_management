import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/separator.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/common/features/order_details/widgets/product_information_card.dart';
import 'package:frontend/features/customer/rating/screens/rating_screen.dart';
import 'package:frontend/models/order.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:frontend/common/features/order_details/widgets/content_container.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final _titleStyle = GoogleFonts.inter(
    fontSize: GlobalVariables.fontSize_14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  final _contentStyle = GoogleFonts.inter(
    fontSize: GlobalVariables.fontSize_14,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return GlobalVariables.darkGreen;
      case 'In Delivery':
        return GlobalVariables.darkBlue;
      case 'Pending':
        return GlobalVariables.darkYellow;
      default:
        return Colors.black;
    }
  }

  String getDayOfWeek(String orderDate) {
    DateTime dateTime = DateTime.parse(orderDate);
    DateFormat dateFormat = DateFormat('EEEE');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    String currentStatus = widget.order.status.value;
    String _getNextStatus(String currentStatus) {
      switch (currentStatus) {
        case "Pending":
          return "In delivery";
        case "In delivery":
          return "Delivered";
        default:
          return "";
      }
    }

    void _changeStatus() {
      setState(() {
        if (currentStatus == "Pending") {
          currentStatus = "In delivery";
        } else if (currentStatus == "In delivery") {
          currentStatus = "Delivered";
        }
        // Handle other status transitions as needed
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Order detail',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: GlobalVariables.fontSize_18,
                fontWeight: FontWeight.w700,
                color: GlobalVariables.darkGreen,
              ),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: GlobalVariables.lightGrey,
          ),
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ContentContainer(
                    title: "Order detail",
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: GlobalVariables.defaultColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order ID",
                                style: _titleStyle,
                              ),
                              Text(
                                widget.order.id.toString(),
                                style: _contentStyle,
                              ),
                            ],
                          ),
                          Separator(color: GlobalVariables.darkGrey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order date", style: _titleStyle),
                              Text(
                                '${DateFormat('kk:mm - yyyy-MM-dd').format(widget.order.orderDate!)}',
                                style: _contentStyle,
                              ),
                            ],
                          ),
                          Separator(color: GlobalVariables.darkGrey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order status",
                                style: _titleStyle,
                              ),
                              Text(
                                widget.order.status.value,
                                style: _contentStyle.copyWith(
                                  color: _getStatusColor(
                                    widget.order.status.value,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  ContentContainer(
                    title: "Shipping info",
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: GlobalVariables.defaultColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SvgPicture.asset(
                                  'assets/vectors/vector_location.svg',
                                  colorFilter: ColorFilter.mode(
                                    GlobalVariables.green,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ]),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Shipping address",
                                  style: _titleStyle,
                                ),
                                Text(
                                  widget.order.detailAddress,
                                  style: _contentStyle,
                                  maxLines: 2,
                                ),
                                Text(
                                  "${widget.order.receiverName} • ${widget.order.receiverPhoneNumber}",
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    color: GlobalVariables.darkGrey,
                                    fontSize: GlobalVariables.fontSize_12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ContentContainer(
                    title: "Estimated time of delivery",
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: GlobalVariables.defaultColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              "${getDayOfWeek(widget.order.estimatedReceiveDate.toString())}, "),
                          Text(
                              '${DateFormat('kk:mm - yyyy-MM-dd').format(widget.order.estimatedReceiveDate)}')
                        ],
                      ),
                    ),
                  ),
                  ContentContainer(
                    title: "Products information",
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        color: GlobalVariables.defaultColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: widget.order.products.asMap().entries.map(
                          (product) {
                            return ProductInformationCard(
                              product: product.value,
                              quantity: widget.order.quantities[product.key],
                              func: () => {
                                Navigator.of(context)
                                    .pushNamed(RatingScreen.routeName)
                              },
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                  ContentContainer(
                    title: "Payment information",
                    child: Column(children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: GlobalVariables.defaultColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/images/googleWallet.png',
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/vectors/vector-google.svg',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "oogle Pay",
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                            color: GlobalVariables.defaultColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Price",
                                  style: _titleStyle,
                                ),
                                Text(
                                  '${widget.order.productPrice.toString()} \$',
                                  style: _contentStyle,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Shipping Price",
                                  style: _titleStyle,
                                ),
                                Text(
                                  '${widget.order.shippingPrice} \$',
                                  style: _contentStyle,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Price (VAT Included)",
                                  style: _titleStyle,
                                ),
                                Text(
                                  '${widget.order.productPrice * 110 / 100 + widget.order.shippingPrice} \$',
                                  style: _contentStyle,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: userProvider.user.role == "admin" &&
                currentStatus != "Delivered"
            ? BottomAppBar(
                child: Container(
                  height: 60, // Adjust the height as needed
                  width:
                      double.infinity, // Make the button span the entire width
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: _changeStatus,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      backgroundColor: GlobalVariables.green,
                    ),
                    child: Text(
                      'Move to \"${_getNextStatus(currentStatus)}\"',
                      style: TextStyle(
                        fontSize: 18,
                        color: GlobalVariables.pureWhite,
                      ),
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
