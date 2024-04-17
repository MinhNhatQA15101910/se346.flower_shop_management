import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/separator.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:frontend/features/admin/order_details/widgets/content_container.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String currentStatus = 'Pending';

  final deliverState = {
    'Pending': GlobalVariables.darkYellow,
    'Indelivery': Colors.blue,
    'Delivered': Colors.green,
    'Cancelled': Colors.red,
  };
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {},
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
                  // Order detail Form
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
                              Text("0000000000", style: contentStyle),
                            ],
                          ),
                          Separator(color: GlobalVariables.darkGrey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order date", style: titleStyle),
                              Text("16:24 21/05/2021", style: contentStyle),
                            ],
                          ),
                          Separator(color: GlobalVariables.darkGrey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Order status", style: titleStyle),
                              Text(currentStatus, style: contentStyle)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Customer Infomation Form
                  ContentContainer(
                    title: "Customer information",
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
                              Text("Customer ID", style: titleStyle),
                              Text("0000000000", style: contentStyle),
                            ],
                          ),
                          Separator(color: GlobalVariables.darkGrey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Name", style: titleStyle),
                              Text("Mai Hoang Nhat Duy", style: contentStyle),
                            ],
                          ),
                          Separator(color: GlobalVariables.darkGrey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Phone number", style: titleStyle),
                              Text("0123456789", style: contentStyle)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Shipping Info Form
                  ContentContainer(
                    title: "Shipping info",
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: GlobalVariables.defaultColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                            'assets/vectors/vector_location.svg',
                            colorFilter: ColorFilter.mode(
                              GlobalVariables.green,
                              BlendMode.srcIn,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Shipping address", style: titleStyle),
                              Text(
                                  "288 Erie Street South Unit D, Leamington, Ontario",
                                  style: contentStyle),
                              Text(
                                "Nick • 0969696969",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  color: GlobalVariables.darkGrey,
                                  fontSize: GlobalVariables.fontSize_12,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  // Estimated time of Delivery Form
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
                        children: [Text("Monday, "), Text("13/11/2024")],
                      ),
                    ),
                  ),
                  // Products Information Form
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
                        children: [],
                      ),
                    ),
                  ),
                  // Payment Info Form
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
        bottomNavigationBar: Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: GlobalVariables.darkGreen,
            ),
            child: Text("????"),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
