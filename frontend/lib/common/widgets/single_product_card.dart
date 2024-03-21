import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleProductCard extends StatelessWidget {
  const SingleProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/product1.png',
              fit: BoxFit.fill,
            ),
          ),
          _buildText('Product Name'),
          RatingBar.builder(
            direction: Axis.horizontal,
            allowHalfRating: true,
            ignoreGestures: true,
            itemCount: 5,
            itemSize: 20,
            unratedColor: GlobalVariables.lightGreen,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: GlobalVariables.green,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          _buildText('Price'),
        ],
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}
