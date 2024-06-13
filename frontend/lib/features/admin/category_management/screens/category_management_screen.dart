import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/admin_drawer.dart';
import 'package:frontend/features/admin/category_management/widgets/large_category_item.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() =>
      _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10), // To center the title
              Text(
                'FlowerFly',
                style: GoogleFonts.pacifico(
                  fontSize: 30,
                  decoration: TextDecoration.none,
                  color: GlobalVariables.darkGreen,
                ),
              ),
              IconButton(
                onPressed: () => {},
                iconSize: 30,
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: GlobalVariables.darkGreen,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: AdminDrawer(),
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
