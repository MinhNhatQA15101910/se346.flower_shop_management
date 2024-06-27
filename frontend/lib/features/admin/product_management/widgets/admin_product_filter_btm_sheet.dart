import 'package:flutter/material.dart';
import 'package:frontend/features/customer/search/widgets/filter_btm_sheet.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/filter_options.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

const List<FilterOptions> priceRangeList = [
  FilterOptions.under29,
  FilterOptions.between30_50,
  FilterOptions.between50_70,
  FilterOptions.over70,
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

  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();

  double _minPrice = 0;
  double _maxPrice = 0;
  bool _isPriceRangeSelected = false;

  @override
  void initState() {
    super.initState();
    _isPriceRangeSelected = false;
    _selectedPriceRange = List.generate(priceRangeList.length, (_) => false);
  }

  void onConfirm() {
    if (_isPriceRangeSelected) {
      for (int i = 0; i < _selectedPriceRange.length; i++) {
        if (_selectedPriceRange[i]) {
          _minPrice = priceRangeList[i].minValue;
          _maxPrice = priceRangeList[i].maxValue;
        }
      }
    } else {
      if (_minPriceController.text.isEmpty ||
          _maxPriceController.text.isEmpty) {
        IconSnackBar.show(
          context,
          label: 'Please enter a price range',
          snackBarType: SnackBarType.fail,
        );
        return;
      }
    }

    Navigator.of(context).pop({'minPrice': _minPrice, 'maxPrice': _maxPrice});
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Wrap(
      children: [
        Padding(
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
                        color: GlobalVariables.blackTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: List.generate(
                  filterOptionsList.length,
                  (index) => _buildToggleButton(
                    index,
                    filterOptionsList,
                    _selectedPriceRange,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Or enter a price range',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inter(
                    color: GlobalVariables.darkGrey,
                    fontSize: 14,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.blackTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _minPriceController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => {
                            setState(() {
                              _selectedPriceRange = List.generate(
                                filterOptionsList.length,
                                (_) => false,
                              );
                              print("TextField Value: $value");
                              _minPrice = double.parse(value);
                            }),
                          },
                          decoration: InputDecoration(
                            hintText: 'Lowest Price',
                            prefixIcon: Align(
                              alignment: Alignment.center,
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Text(
                                '\$ |',
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
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.blackTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _maxPriceController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => {
                            setState(() {
                              _selectedPriceRange = List.generate(
                                filterOptionsList.length,
                                (_) => false,
                              );
                              _maxPrice = double.parse(value);
                            }),
                          },
                          decoration: InputDecoration(
                            hintText: 'Highest Price',
                            prefixIcon: Align(
                              alignment: Alignment.center,
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: Text(
                                '\$ |',
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
                      ],
                    ),
                  ),
                ],
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
                        'Clear',
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
                      onPressed: () => onConfirm(),
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
      ],
    );
  }

  Widget _buildToggleButton(
    int index,
    List<FilterOptions> selectedList,
    List<bool> selectedListState,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            for (int i = 0; i < selectedListState.length; i++) {
              if (i != index) {
                selectedListState[i] = false;
              }
            }
            _isPriceRangeSelected = true;
            _minPriceController.clear();
            _maxPriceController.clear();
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
        child: Text(selectedList[index].title),
      ),
    );
  }

  //dispose the text editing controller
  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }
}
