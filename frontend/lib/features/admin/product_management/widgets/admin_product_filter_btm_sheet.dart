import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';

const List<String> priceRangeList = [
  'Under 100.000đ',
  '100.000đ - 200.000đ',
  '200.000đ - 750.000đ',
  'Over 750.000đ',
];

const List<String> productTypeList = [
  'New',
  'On sale',
];

const List<String> categoryList = [
  'Category 1',
  'Category 2',
  'Category 3',
  'Category 4',
  'Category 5',
];

const List<String> typeList = [
  'Type 1',
  'Type 2',
  'Type 3',
  'Type 4',
  'Type 5',
];

const List<String> occasionList = [
  'Occasion 1',
  'Occasion 2',
  'Occasion 3',
  'Occasion 4',
  'Occasion 5',
];

class AdminProductFilterBtmSheet extends StatefulWidget {
  const AdminProductFilterBtmSheet({super.key});

  @override
  State<AdminProductFilterBtmSheet> createState() =>
      _AdminProductFilterBtmSheetState();
}

class _AdminProductFilterBtmSheetState
    extends State<AdminProductFilterBtmSheet> {
  late List<bool> _selectedPriceRange;
  late List<bool> _selectedProductType;

  @override
  void initState() {
    super.initState();
    _selectedPriceRange = List.generate(priceRangeList.length, (_) => false);
    _selectedProductType = List.generate(productTypeList.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      width: GlobalVariables.screenWidth,
      height: GlobalVariables.screenHeight * 0.6 + keyboardSpace,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 12.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: GlobalVariables.lightGrey),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 50),
                  Text(
                    'Filter',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                primary: true,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Price',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 12,
                    alignment: WrapAlignment.start,
                    children: List.generate(
                      priceRangeList.length,
                      (index) => _buildToggleButton(
                          index, priceRangeList, _selectedPriceRange),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Or enter a price range:',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: GlobalVariables.darkGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        _buildPriceRangeTextField('From', 'Lowest Price'),
                        SizedBox(
                          width: 8,
                        ),
                        _buildPriceRangeTextField('To', 'Highest Price'),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Choose category',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      _buildCategoryDropdown('Category', categoryList),
                      _buildCategoryDropdown('Type', typeList),
                      _buildCategoryDropdown('Occasion', occasionList),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Product type',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 12,
                    alignment: WrapAlignment.start,
                    children: List.generate(
                      productTypeList.length,
                      (index) => _buildToggleButton(
                          index, productTypeList, _selectedProductType),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: GlobalVariables.darkGrey),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      side: BorderSide(
                        width: 1.5,
                        color: GlobalVariables.green,
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        color: GlobalVariables.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      backgroundColor: GlobalVariables.green,
                      side: BorderSide(
                        width: 1.5,
                        color: Colors.transparent,
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(
      int index, List<String> selectedList, List<bool> selectedListState) {
    return OutlinedButton(
        onPressed: () {
          setState(() {
            selectedListState[index] = !selectedListState[index];
          });
        },
        style: OutlinedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          foregroundColor: selectedListState[index]
              ? GlobalVariables.green
              : GlobalVariables.darkGrey,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          side: BorderSide(
            width: 1.5,
            color: selectedListState[index]
                ? GlobalVariables.green
                : GlobalVariables.darkGrey,
          ),
        ),
        child: Text(
          selectedList[index],
          style: GoogleFonts.inter(
            color: selectedListState[index]
                ? GlobalVariables.green
                : GlobalVariables.darkGrey,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ));
  }

  Widget _buildPriceRangeTextField(String label, String hintText) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextField(
            style: GoogleFonts.inter(
              color: GlobalVariables.darkGrey,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              prefixIconColor: GlobalVariables.darkGrey,
              suffixIconColor: GlobalVariables.darkGrey,
              hintStyle: GoogleFonts.inter(
                color: GlobalVariables.darkGrey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: GlobalVariables.lightGrey,
                ),
              ),
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown(String label, List<String> categoryList) {
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
            hintText: categoryList[0],
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
}
