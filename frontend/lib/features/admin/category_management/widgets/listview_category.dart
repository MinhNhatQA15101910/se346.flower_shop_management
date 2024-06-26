import 'package:flutter/material.dart';
import 'package:frontend/features/admin/category_management/widgets/category_item.dart';
import 'package:frontend/models/occasion.dart';
import 'package:frontend/models/type.dart';

class ListViewCategory extends StatelessWidget {
  const ListViewCategory({
    super.key,
    this.types,
    this.occasions,
    required this.onUpdate,
  });

  final List<Type>? types;
  final List<Occasion>? occasions;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    final length = types != null
        ? types!.length
        : occasions != null
            ? occasions!.length
            : 0;
    final cardName = types != null
        ? 'type'
        : occasions != null
            ? 'occasion'
            : "";

    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (cardName == 'type') {
            return CategoryItem(
              type: types![index],
              onUpdate: onUpdate,
            );
          } else {
            return CategoryItem(
              occasion: occasions![index],
              onUpdate: onUpdate,
            );
          }
        },
      ),
    );
  }
}
