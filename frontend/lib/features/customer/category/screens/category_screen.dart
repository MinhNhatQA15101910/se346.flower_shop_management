import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/customer/category/widgets/large_category_item.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Category',
                style: GoogleFonts.pacifico(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    decoration: TextDecoration.none,
                    color: GlobalVariables.darkGreen,
                  ),
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            LargeCategoryItem(
              titleText: 'Combo',
              imagePath: 'assets/images/img_combo.png',
            ),
            SizedBox(height: 10),
            LargeCategoryItem(
              titleText: 'Cake',
              imagePath: 'assets/images/img_cake.png',
            ),
            SizedBox(height: 10),
            LargeCategoryItem(
              titleText: 'Flower',
              imagePath: 'assets/images/img_flower.png',
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
