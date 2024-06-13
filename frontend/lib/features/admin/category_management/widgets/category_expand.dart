import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/category_management/widgets/category_item.dart';

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
            children: [
              CategoryItem(
                imagePath: 'assets/images/img_category_demo.png',
                title: 'Category 1',
                description: 'Types/Occasions',
              ),
              CategoryItem(
                imagePath: 'assets/images/img_category_demo.png',
                title: 'Category 1',
                description: 'Types/Occasions',
              ),
              CategoryItem(
                imagePath: 'assets/images/img_category_demo.png',
                title: 'Category 1',
                description: 'Types/Occasions',
              ),
              CategoryItem(
                imagePath: 'assets/images/img_category_demo.png',
                title: 'Category 1',
                description: 'Types/Occasions',
              ),
              CategoryItem(
                imagePath: 'assets/images/img_category_demo.png',
                title: 'Category 1',
                description: 'Types/Occasions',
              ),
              CategoryItem(
                imagePath: 'assets/images/img_category_demo.png',
                title: 'Category 1',
                description: 'Types/Occasions',
              ),
              CategoryItem(
                imagePath: 'assets/images/img_category_demo.png',
                title: 'Category 1',
                description: 'Types/Occasions',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: GlobalVariables.customButton(
                  buttonText: widget.titleText == 'Types'
                      ? 'Add a type'
                      : 'Add an occasion',
                  borderColor: GlobalVariables.green,
                  fillColor: Colors.white,
                  textColor: GlobalVariables.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
