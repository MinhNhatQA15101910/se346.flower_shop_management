import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class RatingIten extends StatefulWidget {
  const RatingIten({
    Key? key,
  }) : super(key: key);

  @override
  _RatingItenState createState() => _RatingItenState();
}

class _RatingItenState extends State<RatingIten> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 12),
          _BoldSizeText('Tap a star to rate above product'),
          SizedBox(height: 12),
          RatingBar.builder(
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 24,
            unratedColor: GlobalVariables.lightYellow,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: GlobalVariables.yellow,
            ),
            onRatingUpdate: (rating) {},
          ),
          SizedBox(height: 24),
          Container(
            width: 160,
            child: GlobalVariables.customButton(
              buttonText: 'Rating',
              borderColor: GlobalVariables.green,
              fillColor: GlobalVariables.green,
              textColor: Colors.white,
              onTap: () => {},
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _BoldSizeText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
