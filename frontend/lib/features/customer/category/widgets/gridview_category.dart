import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/common/widgets/single_category_card.dart';
import 'package:frontend/models/occasion.dart';
import 'package:frontend/models/type.dart';

class GridViewCategory extends StatelessWidget {
  const GridViewCategory({
    super.key,
    this.types,
    this.occasions,
  });

  final List<Type>? types;
  final List<Occasion>? occasions;

  @override
  Widget build(BuildContext context) {
    final length = types != null ? types!.length : occasions!.length;
    final cardName = types != null ? 'type' : 'occasion';

    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          childAspectRatio: 41 / 57,
        ),
        itemBuilder: (context, index) {
          if (cardName == 'type') {
            return SingleCategoryCard(
              type: types![index],
            );
          } else {
            return SingleCategoryCard(
              occasion: occasions![index],
            );
          }
        },
      ),
    );
  }
}
