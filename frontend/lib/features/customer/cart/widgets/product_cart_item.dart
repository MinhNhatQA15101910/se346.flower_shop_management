import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductCartItem extends StatelessWidget {
  final String productName;
  final String imagePath;
  final int price;
  final int quantity;
  const ProductCartItem({
    super.key,
    required this.productName,
    required this.imagePath,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.1,
        secondaryActions: [
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: GlobalVariables.lightRed,
              border: Border(
                top: BorderSide(color: GlobalVariables.darkRed, width: 1),
                bottom: BorderSide(color: GlobalVariables.darkRed, width: 1),
                left: BorderSide(color: GlobalVariables.darkRed, width: 1),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: IconSlideAction(
              color: Colors.transparent,
              iconWidget: SvgPicture.asset(
                'assets/images/vector_cancel.svg',
                width: 16,
                height: 16,
                color: GlobalVariables.darkRed,
              ),
              onTap: () {
                // Handle tap here
              },
            ),
          ),
        ],
        child: Container(
          padding: EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _productText(productName),
                        SizedBox(height: 8),
                        _pricetText(price.toString()),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Handle tap
                              },
                              child: SvgPicture.asset(
                                'assets/images/vector_decrement_button.svg',
                                width: 40,
                                height: 40,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: 40,
                              height: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFFDCDCE2)),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  _productNumberText(quantity.toString())
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                // Handle tap here
                              },
                              child: SvgPicture.asset(
                                'assets/images/vector_increment_button.svg',
                                width: 40,
                                height: 40,
                                color: GlobalVariables.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 2,
                color: GlobalVariables.lightGrey,
                margin: EdgeInsets.only(left: 16, right: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productText(String text) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        fontSize: 15,
        color: Colors.black,
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _pricetText(String text) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        fontSize: 15,
        color: Colors.black,
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _productNumberText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.black,
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
