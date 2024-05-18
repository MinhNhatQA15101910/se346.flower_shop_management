import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/occasion.dart';
import 'package:frontend/models/type.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleCategoryCard extends StatelessWidget {
  const SingleCategoryCard({
    super.key,
    this.category,
    this.type,
    this.occasion,
  });

  final Category? category;
  final Type? type;
  final Occasion? occasion;

  String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = category != null
        ? category!.imageUrl
        : type != null
            ? category!.imageUrl
            : occasion != null
                ? occasion!.imageUrl
                : '';
    final name = category != null
        ? category!.name
        : type != null
            ? category!.name
            : occasion != null
                ? occasion!.name
                : '';

    return Container(
      width: 64,
      margin: const EdgeInsets.only(
        top: 8,
        left: 8,
        right: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: Text(
              capitalize(name),
              style: GoogleFonts.inter(
                color: GlobalVariables.darkGreen,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
