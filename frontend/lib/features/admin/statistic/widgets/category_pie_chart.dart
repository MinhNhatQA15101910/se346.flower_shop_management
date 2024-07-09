import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/statistic/models/chart_value.dart';
import 'package:frontend/features/admin/statistic/services/statistic_service.dart';
import 'package:frontend/features/admin/statistic/widgets/indicator_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPieChart extends StatefulWidget {
  const CategoryPieChart({super.key});

  @override
  State<StatefulWidget> createState() => CategoryPieChartState();
}

class CategoryPieChartState extends State {
  int touchedIndex = -1;
  String selectedCategory = 'All';
  String selectedCategorychildren = 'All';
  final _statisticSevice = StatisticService();

  List<ChartValue> _chartValues = [];

  void _fetchAllChartValues() async {
    _chartValues = await _statisticSevice.fetchAllChartValues(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _fetchAllChartValues();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalVariables.customContainer(
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
                height: 1,
                color: GlobalVariables.lightGrey,
              ),
            ],
          ),
          SizedBox(height: 40),
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
            padding: const EdgeInsets.only(top: 40),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: _chartValues
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

    for (int i = 0; i < _chartValues.length; i++) {
      const shadows = [Shadow(color: Colors.black, blurRadius: 1)];
      sections.add(
        PieChartSectionData(
          color: GlobalVariables.chartColors[i],
          value: _chartValues[i].value,
          title: '${_chartValues[i].value}',
          radius: touchedIndex == i ? 130 : 120,
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
}
