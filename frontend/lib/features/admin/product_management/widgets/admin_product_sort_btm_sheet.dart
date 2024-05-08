import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/constants/global_variables.dart';

List<Widget> sortOptionsList = [
  Text('Popular'),
  Text('Top selling'),
  Text('Price: Low to High'),
  Text('Price: High to Low'),
];

class AdminProductSortBtmSheet extends StatefulWidget {
  const AdminProductSortBtmSheet({super.key});

  @override
  State<AdminProductSortBtmSheet> createState() =>
      _AdminProductSortBtmSheetState();
}

class _AdminProductSortBtmSheetState extends State<AdminProductSortBtmSheet> {
  late List<bool> _selectedSortOption;

  @override
  void initState() {
    super.initState();
    _selectedSortOption = List.generate(sortOptionsList.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: GlobalVariables.screenWidth,
        height: GlobalVariables.screenHeight * 0.3,
        child: Padding(
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
                itemCount: sortOptionsList.length,
                itemBuilder: (context, index) {
                  return _buildSortOption(
                      index, sortOptionsList, _selectedSortOption);
                },
              ),
            ],
          ),
        ));
  }

  Widget _buildSortOption(
      int index, List<Widget> selectedList, List<bool> selectedListState) {
    return ListTile(
      title: selectedList[index],
      onTap: () {
        setState(() {
          for (int i = 0; i < selectedListState.length; i++) {
            if (i != index) {
              selectedListState[i] = false;
            }
          }
          selectedListState[index] = !selectedListState[index];
          Navigator.of(context).pop();
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
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
