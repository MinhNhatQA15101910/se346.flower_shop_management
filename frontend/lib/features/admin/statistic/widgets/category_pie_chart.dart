import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/statistic/models/chart_value.dart';
import 'package:frontend/features/admin/statistic/widgets/indicator_chart.dart';
import 'package:google_fonts/google_fonts.dart';

final List<ChartValue> chartValueList = [
  ChartValue(name: 'Product 1', value: 40),
  ChartValue(name: 'Product 2', value: 30),
  ChartValue(name: 'Product 3', value: 20),
  ChartValue(name: 'Product 4', value: 10),
];

class CategoryPieChart extends StatefulWidget {
  const CategoryPieChart({super.key});

  @override
  State<StatefulWidget> createState() => CategoryPieChartState();
}

class CategoryPieChartState extends State {
  int touchedIndex = -1;
  String selectedCategory = 'All';
  String selectedCategorychildren = 'All';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: GlobalVariables.black,
                    ),
                  ),
                  Text(
                    'Product percent for each category',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: GlobalVariables.darkGrey,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.info,
                color: GlobalVariables.darkGrey,
              )
            ],
          ),
          SizedBox(height: 16),
          Column(
            children: [
              Container(
                height: 1,
                color: GlobalVariables.lightGrey,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<String>(
                      value: 'All',
                      groupValue: selectedCategory,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      activeColor: GlobalVariables.green,
                      fillColor:
                          MaterialStateProperty.all(GlobalVariables.green),
                    ),
                    _interRegular12('All'),
                    SizedBox(
                      width: 12,
                    ),
                    Radio<String>(
                      value: 'Combo',
                      groupValue: selectedCategory,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      activeColor: GlobalVariables.green,
                      fillColor:
                          MaterialStateProperty.all(GlobalVariables.green),
                    ),
                    _interRegular12('Combo'),
                    SizedBox(
                      width: 12,
                    ),
                    Radio<String>(
                      value: 'Flower',
                      groupValue: selectedCategory,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      activeColor: GlobalVariables.green,
                      fillColor:
                          MaterialStateProperty.all(GlobalVariables.green),
                    ),
                    _interRegular12('Flower'),
                    SizedBox(
                      width: 12,
                    ),
                    Radio<String>(
                      value: 'Cake',
                      groupValue: selectedCategory,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                      activeColor: GlobalVariables.green,
                      fillColor:
                          MaterialStateProperty.all(GlobalVariables.green),
                    ),
                    _interRegular12('Cake'),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: GlobalVariables.lightGrey,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<String>(
                      value: 'All',
                      groupValue: selectedCategorychildren,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCategorychildren = value!;
                        });
                      },
                      activeColor: GlobalVariables.green,
                      fillColor:
                          MaterialStateProperty.all(GlobalVariables.green),
                    ),
                    _interRegular12('All'),
                    SizedBox(
                      width: 12,
                    ),
                    Radio<String>(
                      value: 'Types',
                      groupValue: selectedCategorychildren,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCategorychildren = value!;
                        });
                      },
                      activeColor: GlobalVariables.green,
                      fillColor:
                          MaterialStateProperty.all(GlobalVariables.green),
                    ),
                    _interRegular12('Types'),
                    SizedBox(
                      width: 12,
                    ),
                    Radio<String>(
                      value: 'Occasions',
                      groupValue: selectedCategorychildren,
                      onChanged: (String? value) {
                        setState(() {
                          selectedCategorychildren = value!;
                        });
                      },
                      activeColor: GlobalVariables.green,
                      fillColor:
                          MaterialStateProperty.all(GlobalVariables.green),
                    ),
                    _interRegular12('Occasions'),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 1.5,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: showingSections(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: chartValueList
                  .asMap()
                  .entries
                  .map((entry) => Indicator(
                        color: GlobalVariables.chartColors[entry.key],
                        text: entry.value.name,
                        isSquare: true,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> sections = [];

    for (int i = 0; i < chartValueList.length; i++) {
      const shadows = [Shadow(color: Colors.black, blurRadius: 1)];
      sections.add(
        PieChartSectionData(
          color: GlobalVariables.chartColors[i],
          value: chartValueList[i].value,
          title: '${chartValueList[i].value}%',
          radius: touchedIndex == i ? 110 : 100,
          titleStyle: GoogleFonts.inter(
            fontSize: touchedIndex == i ? 14 : 12,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
            shadows: shadows,
          ),
        ),
      );
    }
    return sections;
  }

  Widget _interRegular12(String text) {
    return Text(
      text,
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
