import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';

class ContentContainer extends StatefulWidget {
  final String title;
  final Widget child;

  const ContentContainer({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  _ContentContainerState createState() => _ContentContainerState();
}

class _ContentContainerState extends State<ContentContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: GlobalVariables.screenWidth,
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: GlobalVariables.fontSize_16,
                fontWeight: FontWeight.w700,
                color: GlobalVariables.darkGreen,
              ),
            ),
          ),
          SizedBox(height: 12),
          widget.child,
        ],
      ),
    );
  }
}
