import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/common/widgets/single_product_card.dart';
import 'package:frontend/constants/global_variables.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search',
                style: GoogleFonts.pacifico(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: GlobalVariables.darkGreen,
                ),
              ),
              IconButton(
                onPressed: () {},
                iconSize: 30,
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: GlobalVariables.darkGreen,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _textController,
              style: GoogleFonts.inter(
                color: GlobalVariables.darkGrey,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                prefixIconColor: GlobalVariables.darkGrey,
                suffixIconColor: GlobalVariables.darkGrey,
                hintStyle: GoogleFonts.inter(
                  color: GlobalVariables.darkGrey,
                  fontSize: 16,
                ),
                hintText: 'Search for products',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    _textController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalVariables.lightGrey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: GlobalVariables.darkGreen),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => {_showFilterBottomSheet(context)},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: GlobalVariables.darkGrey,
                    shadowColor: Colors.transparent,
                    side: const BorderSide(color: GlobalVariables.darkGrey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.filter_alt_outlined),
                      Text('Filter'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => {_showSortBottomSheet(context)},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: GlobalVariables.darkGreen,
                    shadowColor: Colors.transparent,
                    side: const BorderSide(color: GlobalVariables.darkGreen),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.sort_outlined),
                      Text('Sort'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return SingleProductCard();
              },
            ),
          ],
        ),
      )),
    );
  }
}

void _showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            _buildBottomSheetButton(
              context: context,
              text: 'Filter 1',
            ),
          ],
        ),
      );
    },
  );
}

// Function to show sort bottom sheet
void _showSortBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        width: double.infinity,
        child: Text('Sort Bottom Sheet'),
      );
    },
  );
}

Widget _buildBottomSheetButton({
  required BuildContext context,
  required String text,
}) {
  return ToggleButtons(
    isSelected: [false],
    borderColor: GlobalVariables.darkGrey,
    selectedBorderColor: GlobalVariables.darkGreen,
    children: [
      Text(text, style: GoogleFonts.inter(color: GlobalVariables.darkGrey)),
    ],
  );
}
