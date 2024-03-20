import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final Widget child;

  const CarouselItem({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Colors.transparent, // Change as needed
      ),
      child: Center(
        child: child, // Your custom content goes here
      ),
    );
  }
}
