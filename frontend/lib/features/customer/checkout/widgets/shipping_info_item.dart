import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingInfoItem extends StatelessWidget {
  final String address;
  final String name;
  final String phoneNumber;
  const ShippingInfoItem({
    required this.address,
    required this.name,
    required this.phoneNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GlobalVariables.customContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: GlobalVariables.darkGreen,
              size: 24,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _semiBoldSizeText('Shipping address'),
                  SizedBox(
                    height: 4,
                  ),
                  _boldSizeText(address),
                  SizedBox(
                    height: 4,
                  ),
                  _detailText(name + ' • ' + phoneNumber),
                ],
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Center(
              child: Icon(
                Icons.edit,
                color: GlobalVariables.darkGreen,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _semiBoldSizeText(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _boldSizeText(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _detailText(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: GlobalVariables.darkGrey,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
