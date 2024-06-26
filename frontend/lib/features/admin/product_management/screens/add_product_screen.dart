import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/constants/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/size.dart';

import 'package:frontend/features/admin/product_management/services/product_management_service.dart';

const List<Size> _sizes = [
  Size.small,
  Size.medium,
  Size.large,
  Size.extra_large,
];

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product-screen';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _productManagementService = ProductManagementService();
  List<File> _selectedImagesList = [];

  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productQuantityController = TextEditingController();
  final _productSalePercentController = TextEditingController();
  final _productColorController = TextEditingController();
  final _productMaterialController = TextEditingController();
  final _productWeightController = TextEditingController();
  final _productDescriptionController = TextEditingController();
  final _productSizeController = TextEditingController();
  final _productCategoryController = TextEditingController();
  final _productTypeController = TextEditingController();
  final _productOccasionController = TextEditingController();

  List<String> _categories = [];
  List<String> _occasions = [];
  List<String> _types = [];

  final _addProdKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final categories =
        await _productManagementService.getCategoryNames(context: context);
    final occasions =
        await _productManagementService.getOccasionNames(context: context);
    final types =
        await _productManagementService.getTypeNames(context: context);

    setState(() {
      _categories = categories;
      _occasions = occasions;
      _types = types;
    });
  }

  void onAddButtonClick() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a product',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: GlobalVariables.darkGreen,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: GlobalVariables.lightGrey,
          child: Form(
            key: _addProdKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _selectedImagesList.isEmpty ? _pickMulImage : null,
                  child: Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: GlobalVariables.screenHeight * 0.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _selectedImagesList.isEmpty
                              ? Image.asset(
                                  'assets/images/placeholderImage.png',
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  _selectedImagesList[0],
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      _selectedImagesList.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedImagesList.removeAt(0);
                                });
                              },
                              style: ButtonStyle(
                                visualDensity: VisualDensity.compact,
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black54),
                                shape:
                                    MaterialStateProperty.all(CircleBorder()),
                              ),
                              icon: Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            )
                          : SizedBox(
                              width: 1,
                              height: 1,
                            ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  width: double.infinity,
                  height: 124,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    shrinkWrap: true,
                    itemCount: _selectedImagesList.length + 1,
                    itemBuilder: (context, index) {
                      return _buildImageStack(
                        index == 0
                            ? null
                            : File(_selectedImagesList[index - 1].path),
                        100,
                        100,
                        index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 8);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField('Product name', 0, false,
                          TextInputType.text, _productNameController),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTextField('Quantity', 1, false,
                              TextInputType.number, _productQuantityController),
                          SizedBox(width: 8),
                          _buildTextField('Regular price', 1, false,
                              TextInputType.number, _productPriceController),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTextField(
                              'Discount percentage',
                              1,
                              false,
                              TextInputType.number,
                              _productSalePercentController),
                          SizedBox(width: 8),
                          _buildTextField('Colors', 1, false,
                              TextInputType.text, _productColorController)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTextField('Material', 1, false,
                              TextInputType.text, _productMaterialController),
                          SizedBox(width: 8),
                          _buildTextField('Weight', 1, false,
                              TextInputType.number, _productWeightController)
                        ],
                      ),
                      _buildDropdownMenu(
                          'Size: ',
                          _sizes.map((e) => e.value).toList(),
                          _productSizeController),
                      _buildTextField('Description', 0, true,
                          TextInputType.text, _productDescriptionController),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Text(
                    'Category path *',
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: GlobalVariables.darkGrey),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      _buildDropdownMenu(
                          'Category:', _categories, _productCategoryController),
                      _buildDropdownMenu(
                          'Type:', _types, _productTypeController),
                      _buildDropdownMenu(
                          'Ocassions', _occasions, _productOccasionController),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 64,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: GlobalVariables.green,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: GlobalVariables.green,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: OutlinedButton(
                onPressed: _handleAddProduct,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  side: BorderSide(
                    color: GlobalVariables.green,
                    width: 1.5,
                  ),
                  backgroundColor: GlobalVariables.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Add',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageStack(File? _selectedImage, double containerWidth,
      double containerHeight, index) {
    return GestureDetector(
      onTap: _selectedImage == null ? _pickMulImage : null,
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            width: containerWidth,
            height: containerHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _selectedImage == null
                  ? Image.asset(
                      'assets/images/placeholderImage.png',
                      fit: BoxFit.fill,
                    )
                  : Image.file(
                      _selectedImage,
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          _selectedImage != null
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedImagesList.removeAt(index - 1);
                    });
                  },
                  icon: Icon(
                    Icons.close_outlined,
                    color: Colors.white,
                    size: 28,
                    shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                  ),
                )
              : SizedBox(
                  width: 1,
                  height: 1,
                ),
        ],
      ),
    );
  }

  Widget _buildTextField(String labelText, int flexIndex, bool multiline,
      TextInputType keyboardType, TextEditingController controller) {
    return Expanded(
      flex: flexIndex,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: GlobalVariables.darkGrey),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              validator: (value) {
                var validateText = null;

                if (value == null) {
                  return validateText;
                }

                switch (labelText) {
                  case 'Product name':
                    if (value.isEmpty || value.length > 200) {
                      validateText =
                          "Invalid name. Please enter a name with less than 200 characters.";
                    }
                    break;
                  case 'Quantity':
                    if (value.isEmpty) {
                      validateText = "Please enter a quantity.";
                    } else {
                      int? quantity = int.tryParse(value);
                      if (quantity == null || quantity <= 0) {
                        validateText = "Please enter valid number.";
                      }
                    }
                    break;
                  case 'Regular price':
                  case 'Discount percentage':
                    if (value.isEmpty) {
                      validateText = "Please enter a value.";
                    } else {
                      double? number = double.tryParse(value);
                      if (number == null || number <= 0) {
                        validateText =
                            "Please enter a valid number greater than 0.";
                      }
                    }
                    break;
                  case 'Weight':
                    double? weight = double.tryParse(value);
                    if (weight == null || weight <= 0) {
                      validateText =
                          "Please enter a valid weight greater than 0.";
                    }
                    break;
                  case 'Description':
                    if (value.isEmpty || value.length > 1000) {
                      validateText =
                          "Invalid description. Please enter a description with less than 1000 characters.";
                    }
                    break;
                  default:
                    break;
                }

                return validateText;
              },
              maxLines: multiline ? 5 : 1,
              decoration: InputDecoration(
                isDense: true,
                hintText: labelText,
                hintStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: GlobalVariables.darkGrey,
                ),
                suffixIcon:
                    Icon(Icons.edit_square, color: GlobalVariables.green),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: GlobalVariables.darkGrey,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: GlobalVariables.green,
                    width: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownMenu(String label, List<String> categoryList,
      TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: GlobalVariables.darkGrey,
            ),
          ),
          DropdownMenu(
            hintText: "Please make your choice.",
            controller: controller,
            width: 224,
            dropdownMenuEntries: categoryList
                .map(
                  (category) => DropdownMenuEntry(
                    label: category,
                    value: category,
                  ),
                )
                .toList(),
            textStyle: GoogleFonts.inter(
              color: GlobalVariables.darkGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            inputDecorationTheme: InputDecorationTheme(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: GlobalVariables.darkGrey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: GlobalVariables.green,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _pickMulImage() async {
    final List<File>? returnImages = await pickImages(_selectedImagesList);
    if (returnImages != null) {
      setState(() {
        _selectedImagesList.addAll(returnImages);
      });
    }
  }

  void _handleAddProduct() {
    if (_addProdKey.currentState!.validate()) {
      setState(() {
        _productManagementService.addProduct(
          context: context,
          name: _productNameController.text,
          price: _productPriceController.text,
          salePercentage: _productSalePercentController.text,
          detailDescription: _productDescriptionController.text,
          size: _productSizeController.text,
          weight: _productWeightController.text,
          color: _productColorController.text,
          material: _productMaterialController.text,
          stock: _productQuantityController.text,
          imageUrls: _selectedImagesList,
          type_ids: _productTypeController.text,
          occasion_ids: _productOccasionController.text,
        );
      });
    }

    Future.delayed(Duration(seconds: 2), () async {
      setState(() {});
    });
    Navigator.pop(context);
  }
}
