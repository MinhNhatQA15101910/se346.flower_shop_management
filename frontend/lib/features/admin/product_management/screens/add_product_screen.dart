import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:image_picker/image_picker.dart';

import 'package:frontend/features/admin/product_management/services/product_management_service.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product-screen';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  File? _selectedMainImage;
  List<XFile> _selectedImagesList = [];

  late ProductManagementService _productManagementService;
  List<String> _categories = [];
  List<String> _occasions = [];
  List<String> _types = [];

  final _addProdKey = GlobalKey<FormState>();
  var _isLoading = false;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _productManagementService = ProductManagementService();
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
                  onTap: _selectedMainImage == null ? _pickMainImage : null,
                  child: Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: GlobalVariables.screenHeight * 0.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _selectedMainImage == null
                              ? Image.asset(
                                  'assets/images/placeholderImage.png',
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  _selectedMainImage!,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      _selectedMainImage != null
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _selectedMainImage = null;
                                });
                              },
                              icon: Icon(
                                Icons.close_outlined,
                                color: Colors.white,
                                size: 28,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 2)
                                ],
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
                      _buildTextField('Product name', 0, false),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTextField('Quantity', 1, false),
                          SizedBox(width: 8),
                          _buildTextField('Regular price', 1, false)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTextField('Discount percentage', 1, false),
                          SizedBox(width: 8),
                          _buildTextField('Colors', 1, false)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTextField('Material', 1, false),
                          SizedBox(width: 8),
                          _buildTextField('Weight', 1, false)
                        ],
                      ),
                      // _buildDropdownMenu('Size: ', categoryList),
                      _buildTextField('Description', 0, true)
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
                      _buildDropdownMenu('Category:', _categories),
                      _buildDropdownMenu('Type:', _types),
                      _buildDropdownMenu('Ocassions', _occasions),
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

  Widget _buildTextField(String labelText, int flexIndex, bool multiline) {
    final TextEditingController controller = TextEditingController();

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
                  case 'Colors':
                    if (value.isEmpty) {
                      validateText = "Please enter a color.";
                    }
                    break;
                  case 'Material':
                    if (value.isEmpty) {
                      validateText = "Please enter a material.";
                    }
                    break;
                  case 'Weight':
                    if (value.isEmpty) {
                      validateText = "Please enter the weight.";
                    } else {
                      double? weight = double.tryParse(value);
                      if (weight == null || weight <= 0) {
                        validateText =
                            "Please enter a valid weight greater than 0.";
                      }
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

  Widget _buildDropdownMenu(String label, List<String> categoryList) {
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
    final List<XFile>? returnImages = await ImagePicker().pickMultiImage();
    if (returnImages != null) {
      setState(() {
        _selectedImagesList.addAll(returnImages);
      });
    }
  }

  Future _pickMainImage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      setState(() {
        _selectedMainImage = File(returnImage.path);
      });
    }
  }

  void _handleAddProduct() {
    if (_addProdKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    }

    Future.delayed(Duration(seconds: 2), () async {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
