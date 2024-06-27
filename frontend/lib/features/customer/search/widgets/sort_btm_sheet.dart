import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/sort_options.dart';

const List<SortOption> sortOptions = [
  SortOption.id,
  SortOption.topSelling,
  SortOption.nameAtoZ,
  SortOption.nameZtoA,
  SortOption.priceHighToLow,
  SortOption.priceLowToHigh,
];

class SortBtmSheet extends StatefulWidget {
  const SortBtmSheet({super.key});

  @override
  State<SortBtmSheet> createState() => _SortBtmSheetState();
}

class _SortBtmSheetState extends State<SortBtmSheet> {
  late List<bool> _selectedSortOption;

  @override
  void initState() {
    super.initState();
    _selectedSortOption = List.generate(sortOptions.length, (_) => false);
  }

  void _confirmSelection() {
    SortOption selectedOption = SortOption.id;
    for (int i = 0; i < _selectedSortOption.length; i++) {
      if (_selectedSortOption[i]) {
        selectedOption = SortOption.values[i];
      }
    }
    Navigator.of(context).pop(selectedOption);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'Sort',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: sortOptions.length,
                itemBuilder: (context, index) {
                  return _buildSortOption(
                    index,
                    sortOptions,
                    _selectedSortOption,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 160,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSortOption = List.generate(
                            sortOptions.length,
                            (_) => false,
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalVariables.lightGrey,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: GlobalVariables.green,
                          ),
                        ),
                      ),
                      child: Text(
                        'Clear',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: GlobalVariables.green,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 160,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        _confirmSelection();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalVariables.green,
                        elevation: 0,
                      ),
                      child: Text(
                        'Confirm',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: GlobalVariables.pureWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSortOption(
    int index,
    List<SortOption> selectedList,
    List<bool> selectedListState,
  ) {
    return ListTile(
      title: Text(selectedList[index].value),
      onTap: () {
        setState(() {
          for (int i = 0; i < selectedListState.length; i++) {
            if (i != index) {
              selectedListState[i] = false;
            }
          }
          selectedListState[index] = !selectedListState[index];
        });
      },
      trailing: selectedListState[index]
          ? Icon(
              Icons.check,
              color: GlobalVariables.green,
            )
          : null,
      titleTextStyle: GoogleFonts.inter(
        color: selectedListState[index]
            ? GlobalVariables.green
            : GlobalVariables.darkGrey,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      tileColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    );
  }
}
