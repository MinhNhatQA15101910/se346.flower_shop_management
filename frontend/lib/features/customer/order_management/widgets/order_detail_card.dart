import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/order_details/screens/order_details_screen.dart';
import 'package:frontend/features/customer/order_management/widgets/order_status.dart';
import 'package:frontend/models/order.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailCard extends StatefulWidget {
  final Order order;

  const OrderDetailCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailCard> createState() => _OrderDetailCardState();
}

class _OrderDetailCardState extends State<OrderDetailCard> {
  void _goToOrderDetails(BuildContext context) {
    Navigator.of(context)
        .pushNamed(OrderDetailsScreen.routeName, arguments: widget.order);
  }

  @override
  Widget build(BuildContext context) {
    final bool _isAdmin = Provider.of<UserProvider>(
          context,
          listen: false,
        ).user.role ==
        "admin";

    return GestureDetector(
      onTap: () => _goToOrderDetails(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _isAdmin == true
                      ? [
                          Text(
                            'Order id: ${widget.order.id.toString()}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Orders Date: ${DateFormat('yyyy-MM-dd – kk:mm').format(widget.order.orderDate!)}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: GlobalVariables.darkGrey,
                            ),
                          ),
                          Text(
                            'Customer Name: ${widget.order.receiverName}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: GlobalVariables.darkGrey,
                            ),
                          ),
                        ]
                      : [
                          OrderStatusWidget(status: widget.order.status.value),
                          SizedBox(
                            height: 20.0,
                          )
                        ],
                ),
                _isAdmin
                    ? OrderStatusWidget(status: widget.order.status.value)
                    : SizedBox()
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8),
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: GlobalVariables.lightGrey),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: NetworkImage(
                            '${widget.order.products[0].imageUrls[0]}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.order.products[0].name}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${widget.order.quantities[0]} x ${widget.order.products[0].salePrice}',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: GlobalVariables.darkGrey),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Method: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/vectors/vector-google.svg',
                      width: 16,
                      height: 16,
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text(
                      'oogle Pay',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
