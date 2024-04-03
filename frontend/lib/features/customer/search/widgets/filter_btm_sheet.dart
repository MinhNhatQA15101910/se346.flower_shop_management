import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';

const List<Widget> priceRangeList = [
  Text('Under 100.000đ'),
  Text('100.000đ - 200.000đ'),
  Text('200.000đ - 750.000đ'),
  Text('Over 750.000đ'),
];

const List<Widget> productTypeList = [
  Text('New'),
  Text('On sale'),
];

class FilterBtmSheet extends StatefulWidget {
  const FilterBtmSheet({super.key});

  @override
  State<FilterBtmSheet> createState() => _FilterBtmSheetState();
}

class _FilterBtmSheetState extends State<FilterBtmSheet> {
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
    return SizedBox(
      width: GlobalVariables.screenWidth,
      height: GlobalVariables.screenHeight * 0.6 + keyboardSpace,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: GlobalVariables.darkGrey),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 50),
                  Text(
                    'Filter',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 20,
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Price',
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: List.generate(
                priceRangeList.length,
                (index) => _buildToggleButton(
                    index, priceRangeList, _selectedPriceRange),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Lowest Price',
                      suffixIcon: Align(
                        alignment: Alignment.center,
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Text(
                          '| đ',
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                      ),
                      hintStyle: GoogleFonts.inter(
                        color: GlobalVariables.darkGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.darkGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Highest Price',
                      suffixIcon: Align(
                        alignment: Alignment.center,
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Text(
                          '| đ',
                          style: GoogleFonts.inter(fontSize: 16),
                        ),
                      ),
                      hintStyle: GoogleFonts.inter(
                        color: GlobalVariables.darkGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: GlobalVariables.darkGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              child: Text(
                'Product type',
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: List.generate(
                productTypeList.length,
                (index) => _buildToggleButton(
                    index, productTypeList, _selectedProductType),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
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
            SizedBox(
              height: keyboardSpace,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(
      int index, List<Widget> selectedList, List<bool> selectedListState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton(
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
        child: selectedList[index],
      ),
    );
  }
}
