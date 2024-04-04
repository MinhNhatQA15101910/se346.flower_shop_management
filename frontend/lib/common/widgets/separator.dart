import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final double thickness;
  final Color color;
  final EdgeInsetsGeometry margin;
  final Text text;

  const Separator({
    Key? key,
    this.thickness = 0.3,
    this.color = Colors.black,
    this.margin = const EdgeInsets.symmetric(vertical: 5.0),
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 8.0),
                height: thickness,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: thickness,
                      color: color,
                    ),
                  ),
                ),
              ),
            ),
            text,
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8.0),
                height: thickness,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: thickness,
                      color: color,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
