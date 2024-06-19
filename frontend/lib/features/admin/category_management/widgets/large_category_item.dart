import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/category_management/widgets/category_expand.dart';
import 'package:frontend/models/category.dart';
import 'package:google_fonts/google_fonts.dart';

class LargeCategoryItem extends StatefulWidget {
  final Category category;

  const LargeCategoryItem({
    super.key,
    required this.category,
  });

  @override
  State<LargeCategoryItem> createState() => _LargeCategoryItemState();
}

class _LargeCategoryItemState extends State<LargeCategoryItem> {
  String _capitalize(String s) {
    return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: GlobalVariables.darkGreen,
              width: 1,
            ),
          ),
          child: ExpansionTile(
            title: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.category.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    _capitalize(widget.category.name),
                    style: GoogleFonts.inter(
                      color: GlobalVariables.darkGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            children: [
              Column(
                children: [
                  CategoryExpand(
                    titleText: 'Types',
                    categoryId: widget.category.id,
                  ),
                  CategoryExpand(
                    titleText: 'Occasions',
                    categoryId: widget.category.id,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
