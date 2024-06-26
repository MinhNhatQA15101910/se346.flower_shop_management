import 'package:flutter/material.dart';

import 'package:frontend/constants/global_variables.dart';

class ProductInformationCard extends StatefulWidget {
  final Function func;

  const ProductInformationCard({
    Key? key,
    required this.func,
  }) : super(key: key);

  @override
  State<ProductInformationCard> createState() => _ProductInformationCardState();
}

class _ProductInformationCardState extends State<ProductInformationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: GlobalVariables.screenWidth,
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () => widget.func,
            child: Text("Concac"),
          )
        ],
      ),
    );
  }
}
