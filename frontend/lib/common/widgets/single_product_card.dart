import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleProductCard extends StatelessWidget {
  const SingleProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Image.asset(
            'assets/product1.png',
            fit: BoxFit.fill,
          ),
        ),
        _buildText('Product Name'),
        RatingBar.builder(
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 20,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        _buildText('Price'),
      ],
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        textStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}
