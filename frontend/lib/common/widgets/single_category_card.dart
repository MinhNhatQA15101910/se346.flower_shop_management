import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/category_products/screens/category_products_screen.dart';
import 'package:frontend/models/occasion.dart';
import 'package:frontend/models/type.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleCategoryCard extends StatelessWidget {
  const SingleCategoryCard({
    super.key,
    this.type,
    this.occasion,
  });

  final Type? type;
  final Occasion? occasion;

  String capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  }

  void navigateToCategoryProductsScreen(BuildContext context) {
    if (type != null) {
      Navigator.of(context).pushNamed(
        CategoryProductsScreen.routeName,
        arguments: type,
      );
    } else {
      Navigator.of(context).pushNamed(
        CategoryProductsScreen.routeName,
        arguments: occasion,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = type != null
        ? type!.imageUrl
        : occasion != null
            ? occasion!.imageUrl
            : '';
    final name = type != null
        ? type!.name
        : occasion != null
            ? occasion!.name
            : '';

    return GestureDetector(
      onTap: () => navigateToCategoryProductsScreen(context),
      child: Container(
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
            Text(
              capitalize(name),
              style: GoogleFonts.inter(
                color: GlobalVariables.darkGreen,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
