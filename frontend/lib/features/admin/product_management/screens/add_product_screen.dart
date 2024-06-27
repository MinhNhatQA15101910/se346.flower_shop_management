import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/models/product.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/size.dart';
import 'package:image_picker/image_picker.dart';
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
  int typeIndex = -1;
  int occasionIndex = -1;
  Product? _product;

  final _addProdKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productArg = ModalRoute.of(context)?.settings.arguments;
    if (productArg != null && productArg is Product) {
      _product = productArg;
      _loadProductDetails();
    }
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

  void _loadProductDetails() {
    if (_product != null) {
      _productNameController.text = _product!.name;
      _productPriceController.text = _product!.price.toString();
      _productQuantityController.text = _product!.stock.toString();
      _productSalePercentController.text = _product!.salePercentage.toString();
      _productColorController.text = _product!.color;
      _productMaterialController.text = _product!.material;
      _productWeightController.text = _product!.weight.toString();
      _productDescriptionController.text = _product!.detailDescription;
      _productSizeController.text = _product!.size.toString();

      // Clear the list first
      _selectedImagesList.clear();

      // Add images to the list
      setState(() {
        _selectedImagesList.addAll(
          _product!.imageUrls.map((url) => File(url)).toList(),
        );
      });
    }
  }

  void _addProduct() async {
    _getTypeIndex();
    _getOccasionIndex();
    String sizeText = '';
    if (_productSizeController.text == "Size.small") sizeText = 'Small';
    if (_productSizeController.text == "Size.medium") sizeText = 'Medium';
    if (_productSizeController.text == "Size.large")
      sizeText = 'Large';
    else
      sizeText = 'Extra_large';
    try {
      await _productManagementService.addProduct(
        context: context,
        name: _productNameController.text,
        price: _productPriceController.text,
        salePercentage: _productSalePercentController.text,
        detailDescription: _productDescriptionController.text,
        size: sizeText,
        weight: _productWeightController.text,
        color: _productColorController.text,
        material: _productMaterialController.text,
        stock: _productQuantityController.text,
        imageUrls: _selectedImagesList,
        type_ids: typeIndex.toString(),
        occasion_ids: occasionIndex.toString(),
      );

      setState(() {
        _productNameController.clear();
        _productPriceController.clear();
        _productQuantityController.clear();
        _productSalePercentController.clear();
        _productColorController.clear();
        _productMaterialController.clear();
        _productWeightController.clear();
        _productDescriptionController.clear();
        _productSizeController.clear();
        _productCategoryController.clear();
        _productTypeController.clear();
        _productOccasionController.clear();
        _selectedImagesList.clear();
        typeIndex = -1;
        occasionIndex = -1;
      });

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context, true); // Pass 'true' to indicate success
      });
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  void _updateProduct() async {
    _getTypeIndex();
    _getOccasionIndex();
    String sizeText = '';
    if (_productSizeController.text == "Size.small") sizeText = 'Small';
    if (_productSizeController.text == "Size.medium") sizeText = 'Medium';
    if (_productSizeController.text == "Size.large") sizeText = 'Large';
    if (_productSizeController.text == "Size.extra_large")
      sizeText = 'Extra_large';

    try {
      bool shouldUpdateImages = _selectedImagesList.isNotEmpty;

      await _productManagementService.updateProduct(
        context: context,
        productId: _product!.id.toString(),
        name: _productNameController.text,
        price: _productPriceController.text,
        salePercentage: _productSalePercentController.text,
        detailDescription: _productDescriptionController.text,
        size: sizeText.isNotEmpty ? sizeText : "Small",
        weight: _productWeightController.text,
        color: _productColorController.text,
        material: _productMaterialController.text,
        stock: _productQuantityController.text,
        imageUrls: shouldUpdateImages ? _selectedImagesList : null,
        type_ids: typeIndex.toString(),
        occasion_ids: occasionIndex.toString(),
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  void _getTypeIndex() {
    for (int i = 0; i < _types.length; i++) {
      if (_types[i] == _productTypeController.text) {
        setState(() {
          typeIndex = i;
        });
        break;
      }
    }
  }

  void _getOccasionIndex() {
    for (int i = 0; i < _occasions.length; i++) {
      if (_occasions[i] == _productOccasionController.text) {
        setState(() {
          occasionIndex = i;
        });
        break;
      }
    }
  }

  Future<List<File>?> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      return images.map((image) => File(image.path)).toList();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _product?.id != null && _product!.id > 0
              ? 'Update product'
              : 'Add a product',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: GlobalVariables.darkGreen,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: GlobalVariables.lightGrey,
                  child: Form(
                    key: _addProdKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _selectedImagesList.isEmpty
                              ? _pickMulImage
                              : null,
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
                                      : _selectedImagesList.first.path
                                              .contains('http')
                                          ? Image.network(
                                              _selectedImagesList.first.path,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.file(
                                              _selectedImagesList.first,
                                              fit: BoxFit.fill,
                                            ),
                                ),
                              ),
                              _selectedImagesList.isNotEmpty
                                  ? Positioned(
                                      top: 8,
                                      right: 8,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _selectedImagesList.removeAt(0);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.close_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        style: ButtonStyle(
                                          visualDensity: VisualDensity.compact,
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.black54),
                                          shape: MaterialStateProperty.all(
                                              CircleBorder()),
                                        ),
                                      ),
                                    )
                                  : SizedBox(width: 1, height: 1),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          child: Text(
                            'Images',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: GlobalVariables.darkGrey,
                            ),
                          ),
                        ),
                        if (_selectedImagesList.isNotEmpty)
                          Container(
                            height: 70,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _selectedImagesList.length,
                              itemBuilder: (context, index) {
                                final image = _selectedImagesList[index];
                                return Stack(
                                  fit: StackFit.loose,
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedImagesList.removeAt(index);
                                        });
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: image.path.contains('http')
                                            ? Image.network(
                                                image.path,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                image,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _selectedImagesList.removeAt(index);
                                        });
                                      },
                                      style: ButtonStyle(
                                        visualDensity: VisualDensity.compact,
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black54),
                                        shape: MaterialStateProperty.all(
                                            CircleBorder()),
                                      ),
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Name *',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: _productNameController,
                            decoration: const InputDecoration(
                              hintText: 'Enter product name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Price *',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: _productPriceController,
                            decoration: const InputDecoration(
                              hintText: 'Enter product price',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product price';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Quantity *',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: _productQuantityController,
                            decoration: const InputDecoration(
                              hintText: 'Enter product quantity',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product quantity';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Sale Percentage',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: _productSalePercentController,
                            decoration: const InputDecoration(
                              hintText: 'Enter sale percentage',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Color',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: _productColorController,
                            decoration: const InputDecoration(
                              hintText: 'Enter product color',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Material',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: _productMaterialController,
                            decoration: const InputDecoration(
                              hintText: 'Enter product material',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Weight',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: _productWeightController,
                            decoration: const InputDecoration(
                              hintText: 'Enter product weight',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextFormField(
                            controller: _productDescriptionController,
                            decoration: const InputDecoration(
                              hintText: 'Enter product description',
                            ),
                            maxLines: 3,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Size',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: DropdownButtonFormField<String>(
                            items: _sizes.map((size) {
                              return DropdownMenuItem<String>(
                                value: size.value,
                                child: Text(size.value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _productCategoryController.text = value!;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Select size',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: DropdownButtonFormField<String>(
                            items: _categories
                                .map((category) => DropdownMenuItem<String>(
                                      value: category,
                                      child: Text(category),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _productCategoryController.text = value!;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Select category',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Type',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: DropdownButtonFormField<String>(
                            items: _types
                                .map((type) => DropdownMenuItem<String>(
                                      value: type,
                                      child: Text(type),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _productTypeController.text = value!;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Select type',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          child: Text(
                            'Occasion',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: DropdownButtonFormField<String>(
                            items: _occasions
                                .map((occasion) => DropdownMenuItem<String>(
                                      value: occasion,
                                      child: Text(occasion),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _productOccasionController.text = value!;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Select occasion',
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
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
                    child: GlobalVariables.customButton(
                      onTap: () {
                        if (_addProdKey.currentState!.validate()) {
                          if (_product?.id != null && _product!.id > 0) {
                            _updateProduct();
                          } else {
                            _addProduct();
                          }
                        }
                      },
                      buttonText: _product?.id != null && _product!.id > 0
                          ? 'Update'
                          : 'Add',
                      borderColor: GlobalVariables.green,
                      fillColor: GlobalVariables.green,
                      textColor: Colors.white,
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

  Future<void> _pickMulImage() async {
    final images = await pickImages();
    if (images != null) {
      setState(() {
        _selectedImagesList.addAll(images);
      });
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productPriceController.dispose();
    _productQuantityController.dispose();
    _productSalePercentController.dispose();
    _productColorController.dispose();
    _productMaterialController.dispose();
    _productWeightController.dispose();
    _productDescriptionController.dispose();
    _productSizeController.dispose();
    _productCategoryController.dispose();
    _productTypeController.dispose();
    _productOccasionController.dispose();
    super.dispose();
  }
}
