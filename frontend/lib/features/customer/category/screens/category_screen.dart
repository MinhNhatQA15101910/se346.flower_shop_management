import 'package:flutter/material.dart';
import 'package:frontend/features/customer/category/widgets/large_category_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Screen1'),
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
