import 'package:flutter/material.dart';

import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/models/product.dart';

class ProductInformationCard extends StatefulWidget {
  final VoidCallback func;
  final Product product;
  final int productQuantity;

  const ProductInformationCard({
    Key? key,
    required this.func,
    required this.product,
    required this.productQuantity,
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
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: GlobalVariables.darkGrey,
            width: 0.5,
          ),
        ),
      ),
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(widget.product.imageUrls[0]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.product.name}",
                  maxLines: 2,
                ),
                Text("${widget.productQuantity} x ${widget.product.salePrice}"),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Transform.translate(
                  offset: Offset(0, -10),
                  child: ElevatedButton(
                    onPressed: widget.func,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.darkGreen,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      textStyle: TextStyle(fontSize: 12),
                    ),
                    child: Text(
                      "Rating",
                      style: TextStyle(
                        fontSize: 12,
                        color: GlobalVariables.pureWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
