import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/loader.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/features/admin/category_management/services/category_management_service.dart';
import 'package:frontend/models/occasion.dart';
import 'package:frontend/models/type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class AddUpdateCategoryBottomSheet extends StatefulWidget {
  const AddUpdateCategoryBottomSheet({
    super.key,
    required this.featureName,
    this.categoryParentId,
    this.categoryId,
  });

  final String featureName;
  final int? categoryParentId;
  final int? categoryId;

  @override
  State<AddUpdateCategoryBottomSheet> createState() =>
      _AddUpdateCategoryBottomSheetState();
}

class _AddUpdateCategoryBottomSheetState
    extends State<AddUpdateCategoryBottomSheet> {
  final _categoryManagementService = CategoryManagementService();

  final _categoryNameController = TextEditingController();

  File? _image = null;

  Type? _type;
  Occasion? _occasion;

  final _formKey = GlobalKey<FormState>();

  bool _isExecuting = false;

  void _selectImages() async {
    var res = await pickOneImage();
    setState(() {
      if (res != null) {
        _image = res;
      }
    });
  }

  void _fetchCategory() async {
    if (widget.featureName == 'Update type') {
      _type = await _categoryManagementService.getType(
        typeId: widget.categoryId!,
        context: context,
      );
    } else if (widget.featureName == 'Update occasion') {
      _occasion = await _categoryManagementService.getOccasion(
        occasionId: widget.categoryId!,
        context: context,
      );
    }

    setState(() {});
  }

  void _executeFeature() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isExecuting = true;
      });

      if (widget.featureName == 'Add type') {
        Future.delayed(Duration(seconds: 2), () async {
          await _categoryManagementService.addType(
            categoryId: widget.categoryParentId!,
            name: _categoryNameController.text,
            image: _image!,
            context: context,
          );
        });

        if (!mounted) return;

        setState(() {
          _isExecuting = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    if (_type != null) {
      _categoryNameController.setText(_type!.name);
    } else if (_occasion != null) {
      _categoryNameController.setText(_occasion!.name);
    } else {
      _categoryNameController.setText('');
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: keyboardSpace,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: Container(
                      child: _boldSizeText(widget.featureName),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    iconSize: 24,
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: GlobalVariables.lightGrey,
              thickness: 1.0,
            ),
            Container(
              padding: EdgeInsets.only(
                bottom: 12,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _selectImages,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: GlobalVariables.lightGrey,
                          ),
                          child: _image != null
                              ? Image.file(
                                  _image!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )
                              : _type != null
                                  ? Image.network(
                                      _type!.imageUrl,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    )
                                  : _occasion != null
                                      ? Image.network(
                                          _occasion!.imageUrl,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(
                                          Icons.add_photo_alternate_outlined,
                                          color: GlobalVariables.darkGrey,
                                          size: 60,
                                        ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _titleText('Category Name *'),
                            SizedBox(
                              height: 4,
                            ),
                            _customTextField(
                              TextInputType.text,
                              'Category Name',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: GlobalVariables.defaultColor,
              thickness: 12.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: GlobalVariables.customButton(
                        onTap: () => Navigator.pop(context),
                        buttonText: 'Cancel',
                        borderColor: GlobalVariables.green,
                        fillColor: Colors.white,
                        textColor: GlobalVariables.green,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      child: _isExecuting
                          ? const Loader()
                          : GlobalVariables.customButton(
                              onTap: _executeFeature,
                              buttonText: widget.featureName == 'Add type' ||
                                      widget.featureName == 'Add occasion'
                                  ? 'Add'
                                  : 'Update',
                              borderColor: GlobalVariables.green,
                              fillColor: GlobalVariables.green,
                              textColor: Colors.white,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }

  Widget _boldSizeText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _titleText(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _customTextField(
    TextInputType inputText,
    String hint,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: GlobalVariables.darkGrey),
      ),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: _categoryNameController,
          cursorColor: GlobalVariables.darkGrey,
          keyboardType: inputText,
          style: GoogleFonts.inter(
            color: GlobalVariables.blackTextColor,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: GlobalVariables.darkGrey,
              fontSize: 16,
            ),
          ),
          validator: (name) {
            if (name == null || name.isEmpty) {
              return 'Please enter type/occasion name.';
            }

            return null;
          },
        ),
      ),
    );
  }
}
