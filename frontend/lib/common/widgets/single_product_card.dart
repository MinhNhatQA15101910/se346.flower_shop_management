import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/product_details/screens/product_details_screen.dart';
import 'package:frontend/models/product.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleProductCard extends StatelessWidget {
  const SingleProductCard({
    super.key,
    required this.product,
  });

  final Product product;

  void navigateToProductDetailsScreen(BuildContext context) {
    Navigator.of(context)
        .pushNamed(ProductDetailsScreen.routeName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToProductDetailsScreen(context),
      child: SizedBox(
        width: 120,
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.imageUrls[0],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Product name
            Text(
              product.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: GlobalVariables.blackTextColor,
              ),
            ),
            const SizedBox(height: 4),

            // Rating Bar and total rating
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RatingBar.builder(
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  initialRating: product.ratingAvg,
                  itemCount: 5,
                  itemSize: 16,
                  unratedColor: GlobalVariables.lightGreen,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                const SizedBox(width: 4),
                Text(
                  '(${product.totalRating})',
                  style: GoogleFonts.inter(
                    color: GlobalVariables.darkGrey,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Product price and sale percentage
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '\$ ${product.salePrice.toString()}',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: GlobalVariables.blackTextColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  decoration: BoxDecoration(
                    color: GlobalVariables.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Center(
                    child: Text(
                      '-${product.salePercentage}%',
                      style: GoogleFonts.inter(
                        color: GlobalVariables.pureWhite,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
