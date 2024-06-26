import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/separator.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/order_details/widgets/product_information_card.dart';
import 'package:frontend/features/customer/rating/screens/rating_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:frontend/features/customer/order_details/widgets/content_container.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/customer-order-details';
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String currentStatus = 'Pending';

  List<Map<String, dynamic>> products = [
    {
      'name': 'Sample Product 1',
      'imageUrl':
          'https://imgs.search.brave.com/p4vjYGLZq07IPi_BDIsHQxBihhRCteK-49mUjTnmL84/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9idXJz/dC5zaG9waWZ5Y2Ru/LmNvbS9waG90b3Mv/ZG9nLXBhd3MuanBn/P3dpZHRoPTEwMDAm/Zm9ybWF0PXBqcGcm/ZXhpZj0wJmlwdGM9/MA',
      'productPrice': '29.99',
      'productQuantity': 2,
    },
    {
      'name': 'Sample Product 2',
      'imageUrl':
          'https://media.gettyimages.com/id/609759172/photo/wet-dog.jpg?s=612x612&w=0&k=20&c=KzYsjqM7FWT7U-5gk_jKTNKGmm_qYn8Y_XUpmgOxUJ4=',
      'productPrice': '19.99',
      'productQuantity': 1,
    },
  ];

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

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
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
                  ContentContainer(
                    title: "Shipping info",
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: GlobalVariables.defaultColor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/vectors/vector_location.svg',
                            colorFilter: ColorFilter.mode(
                              GlobalVariables.green,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Shipping address", style: titleStyle),
                                Text(
                                  "288 Erie Street South Unit D, Leamington, Ontario",
                                  style: contentStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Nick • 0969696969",
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
                        children: [Text("Monday, "), Text("13/11/2024")],
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
