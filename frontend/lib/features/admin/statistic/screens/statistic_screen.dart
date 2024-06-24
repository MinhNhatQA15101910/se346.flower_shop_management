import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/statistic/widgets/pie_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  final titleStyle = GoogleFonts.inter(
    fontSize: GlobalVariables.fontSize_14,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  final contentStyle = GoogleFonts.inter(
    fontSize: GlobalVariables.fontSize_14,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {},
          ),
          title: Text(
            'Order detail',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: GlobalVariables.fontSize_18,
                fontWeight: FontWeight.w700,
                color: GlobalVariables.darkGreen,
              ),
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              PieChartSample3(),
            ],
          ),
        ),
      ),
    );
  }
}
