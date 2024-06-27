import 'package:flutter/material.dart';
import 'package:frontend/features/admin/product_management/screens/add_product_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/models/product.dart';

class ProductManageCard extends StatelessWidget {
  const ProductManageCard({
    super.key,
    required this.product,
  });
  final Product product;

  void navigateToAddProductScreen(BuildContext context) {
    Navigator.of(context)
        .pushNamed(AddProductScreen.routeName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 76,
                height: 76,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrls[0],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Category: Combo',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: GlobalVariables.darkGrey,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: GlobalVariables.yellow,
                        ),
                        Text(
                          '${product.ratingAvg} / 5.0 (${product.totalRating})',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: GlobalVariables.darkGrey),
                        ),
                      ],
                    ),
                    Text(
                      '\$ ${product.salePrice}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  navigateToAddProductScreen(context);
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: GlobalVariables.lightYellow,
                  ),
                  child: Icon(
                    Icons.edit_square,
                    color: GlobalVariables.darkYellow,
                    size: 14,
                  ),
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: GlobalVariables.lightRed,
                  ),
                  child: Icon(
                    Icons.delete_outline_outlined,
                    color: GlobalVariables.darkRed,
                    size: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
