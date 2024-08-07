import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/category_management/widgets/add_update_category_btm_sheet.dart';
import 'package:frontend/features/admin/category_management/widgets/listview_category.dart';
import 'package:frontend/features/customer/category/services/category_service.dart';
import 'package:frontend/models/occasion.dart';
import 'package:frontend/models/type.dart';

class CategoryExpand extends StatefulWidget {
  final String titleText;
  final int categoryId;

  const CategoryExpand({
    super.key,
    required this.titleText,
    required this.categoryId,
  });

  @override
  State<CategoryExpand> createState() => _CategoryExpandState();
}

class _CategoryExpandState extends State<CategoryExpand> {
  final _categoryService = CategoryService();

  List<Object>? _objectList;

  Future<void> _fetchObjectList() async {
    List<Object>? objectList;
    if (widget.titleText == 'Types') {
      objectList = await _categoryService.fetchAllTypes(
        context,
        widget.categoryId,
      );
    } else {
      objectList = await _categoryService.fetchAllOccasions(
        context,
        widget.categoryId,
      );
    }

    if (!mounted) return;

    setState(() {
      _objectList = objectList;
    });
  }

  Future<void> _displayAddCategoryBtmSheet() async {
    final result = await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: AddUpdateCategoryBottomSheet(
            featureName:
                widget.titleText == 'Types' ? 'Add type' : 'Add occasion',
            categoryParentId: widget.categoryId,
          ),
        );
      },
    );

    if (result == true) {
      _fetchObjectList();
    }
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
                ListViewCategory(
                  types: _objectList as List<Type>?,
                  onUpdate: _fetchObjectList,
                ),
              if (widget.titleText == 'Occasions')
                ListViewCategory(
                  occasions: _objectList as List<Occasion>?,
                  onUpdate: _fetchObjectList,
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
                  onTap: _displayAddCategoryBtmSheet,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
