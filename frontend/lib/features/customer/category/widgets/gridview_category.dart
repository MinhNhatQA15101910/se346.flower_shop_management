import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/common/widgets/single_category_card.dart';

class GridViewCategory extends StatelessWidget {
  const GridViewCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          (8 / 4).ceil(),
          (index) {
            final startIndex = index * 4;
            final endIndex = startIndex + 4;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                endIndex < 8 ? 4 : 8 - startIndex,
                (innerIndex) => Container(),
                // (innerIndex) => const SingleCategoryCard(
                //   titleText: 'Category 1',
                //   imagePath: 'assets/images/img_category_demo.png',
                // ),
              ),
            );
          },
        ),
      ),
    );
  }
}
