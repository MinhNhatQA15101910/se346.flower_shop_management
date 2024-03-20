import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/category/widgets/gridview_category.dart';

class CategoryExpand extends StatefulWidget {
  final String titleText;

  const CategoryExpand({super.key, required this.titleText});

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
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                widget.titleText,
                style: const TextStyle(
                  color: Color(0xFF198155),
                  fontSize: 20,
                  fontFamily: 'Inter',
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
