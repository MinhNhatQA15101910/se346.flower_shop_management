import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/category/services/category_service.dart';
import 'package:frontend/features/customer/category/widgets/gridview_category.dart';
import 'package:frontend/models/occasion.dart';
import 'package:frontend/models/type.dart';

class CategoryExpand extends StatefulWidget {
  const CategoryExpand({
    super.key,
    required this.titleText,
    required this.categoryId,
  });

  final String titleText;
  final int categoryId;

  @override
  State<CategoryExpand> createState() => _CategoryExpandState();
}

class _CategoryExpandState extends State<CategoryExpand> {
  final _categoryService = CategoryService();

  List<Object>? _objectList;

  void _fetchObjectList() async {
    if (widget.titleText == 'Types') {
      _objectList = await _categoryService.fetchAllTypes(
        context,
        widget.categoryId,
      );
    } else {
      _objectList = await _categoryService.fetchAllOccasions(
        context,
        widget.categoryId,
      );
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _fetchObjectList();
  }

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
              if (widget.titleText == 'Types')
                GridViewCategory(
                  types: _objectList as List<Type>?,
                ),
              if (widget.titleText == 'Occasions')
                GridViewCategory(
                  occasions: _objectList as List<Occasion>?,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
