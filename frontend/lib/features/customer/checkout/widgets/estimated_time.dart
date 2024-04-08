import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EstimatedTime extends StatelessWidget {
  final DateTime datetime;
  const EstimatedTime({
    required this.datetime,
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
              Icons.calendar_today,
              color: GlobalVariables.darkGreen,
              size: 24,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: _semiBoldSizeText(
                DateFormat('EEEE, dd/MM/yyyy').format(datetime),
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
}
