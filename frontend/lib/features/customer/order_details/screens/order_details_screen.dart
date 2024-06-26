import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/separator.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/order_details/widgets/product_information_card.dart';
import 'package:frontend/features/customer/rating/screens/rating_screen.dart';
import 'package:frontend/models/order.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:frontend/features/customer/order_details/widgets/content_container.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/customer-order-details';
  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final titleStyle = GoogleFonts.inter(
    fontSize: GlobalVariables.fontSize_14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  final contentStyle = GoogleFonts.inter(
    fontSize: GlobalVariables.fontSize_14,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  Color getStatusColor(String status) {
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: (() {
              _goBack(context);
            }),
          ),
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
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order ID", style: titleStyle),
                              Text(widget.order.id.toString(),
                                  style: contentStyle),
                            ],
                          ),
                          Separator(color: GlobalVariables.darkGrey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order date", style: titleStyle),
                              Text(
                                  '${DateFormat('kk:mm - yyyy-MM-dd').format(widget.order.orderDate!)}',
                                  style: contentStyle),
                            ],
                          ),
                          Separator(color: GlobalVariables.darkGrey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order status", style: titleStyle),
                              Text(widget.order.status.value,
                                  style: contentStyle.copyWith(
                                      color: getStatusColor(
                                          widget.order.status.value)))
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
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: GlobalVariables.defaultColor,
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
                                Text("Shipping address", style: titleStyle),
                                Text(
                                  widget.order.detailAddress,
                                  style: contentStyle,
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
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: GlobalVariables.defaultColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProductInformationCard(
                              func: () => {
                                    Navigator.of(context)
                                        .pushNamed(RatingScreen.routeName)
                                  })
                        ],
                      ),
                    ),
                  ),
                  ContentContainer(
                    title: "Payment infomation",
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: GlobalVariables.defaultColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
