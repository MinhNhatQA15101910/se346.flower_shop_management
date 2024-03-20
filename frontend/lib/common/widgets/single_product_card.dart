import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/constants/global_variables.dart';
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
        _buildText('Rating'),
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
