import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/category/widgets/gridview_category.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryExpand extends StatefulWidget {
  const CategoryExpand({
    super.key,
    required this.titleText,
  });

  final String titleText;

  @override
  State<CategoryExpand> createState() => _CategoryExpandState();
}

class _CategoryExpandState extends State<CategoryExpand> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: GlobalVariables.darkGrey,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ExpansionTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Text(
                widget.titleText,
                style: GoogleFonts.inter(
                  color: GlobalVariables.darkGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            children: const [
              GridViewCategory(),
            ],
          ),
        ),
      ),
    );
  }
}
