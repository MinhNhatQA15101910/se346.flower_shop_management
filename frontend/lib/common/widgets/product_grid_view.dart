import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/loader.dart';
import 'package:frontend/common/widgets/single_product_card.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/models/product.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.productList,
    required this.controller,
    required this.hasProduct,
    required this.onRefresh,
  });

  final ScrollController controller;
  final List<Product> productList;
  final bool hasProduct;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return productList.isEmpty
        ? const Loader()
        : RefreshIndicator(
            onRefresh: onRefresh,
            child: GridView.builder(
              controller: controller,
              itemCount: productList.length + 2,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (context, index) {
                if (index < productList.length) {
                  return SingleProductCard(
                    product: productList[index],
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    child: hasProduct
                        ? Loader()
                        : Center(
                            child: Text(
                              'No more product to load.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: GlobalVariables.green,
                              ),
                            ),
                          ),
                  );
                }
              },
              physics: const BouncingScrollPhysics(),
            ),
          );
  }
}
