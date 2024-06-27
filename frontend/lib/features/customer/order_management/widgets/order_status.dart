import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';

class OrderStatusWidget extends StatelessWidget {
  final String status;

  OrderStatusWidget({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: getStatusColor(status).withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: getStatusColor(status),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return GlobalVariables.orange;
      case 'In Delivery':
        return GlobalVariables.blue;
      case 'Delivered':
        return GlobalVariables.green;
      case 'Cancelled':
        return GlobalVariables.red;
      default:
        return GlobalVariables.gray;
    }
  }
}
