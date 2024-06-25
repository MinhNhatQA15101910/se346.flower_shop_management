import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/statistic/models/chart_value.dart';
import 'package:frontend/features/admin/statistic/services/statistic_service.dart';
import 'package:frontend/features/admin/statistic/widgets/legend_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthlyRevenueBarChart extends StatefulWidget {
  const MonthlyRevenueBarChart({Key? key}) : super(key: key);

  @override
  _MonthlyRevenueBarChartState createState() => _MonthlyRevenueBarChartState();
}

class _MonthlyRevenueBarChartState extends State<MonthlyRevenueBarChart> {
  final betweenSpace = 0.2;

  List<BarChartGroupData> barData = [];

  static BarChartGroupData generateGroupData(int x, double value) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: value,
          color: GlobalVariables.green,
          width: 5,
        ),
      ],
    );
  }

  double getMaxY() {
    double maxY = 0;
    for (var group in barData) {
      for (var rod in group.barRods) {
        if (rod.toY > maxY) {
          maxY = rod.toY;
        }
      }
    }
    return maxY;
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'JAN';
        break;
      case 1:
        text = 'FEB';
        break;
      case 2:
        text = 'MAR';
        break;
      case 3:
        text = 'APR';
        break;
      case 4:
        text = 'MAY';
        break;
      case 5:
        text = 'JUN';
        break;
      case 6:
        text = 'JUL';
        break;
      case 7:
        text = 'AUG';
        break;
      case 8:
        text = 'SEP';
        break;
      case 9:
        text = 'OCT';
        break;
      case 10:
        text = 'NOV';
        break;
      case 11:
        text = 'DEC';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(value.toStringAsFixed(1), style: style),
    );
  }

  final _statisticSevice = StatisticService();
  List<ChartValue> _chartValues = [];

  void _fetchAllChartValues() async {
    _chartValues = await _statisticSevice.fetchAllChartValuesRevenue(context);
    setState(() {
      barData = [
        generateGroupData(0, _chartValues[0].value),
        generateGroupData(1, _chartValues[1].value),
        generateGroupData(2, _chartValues[2].value),
        generateGroupData(3, _chartValues[3].value),
        generateGroupData(4, _chartValues[4].value),
        generateGroupData(5, _chartValues[5].value),
        generateGroupData(6, _chartValues[6].value),
        generateGroupData(7, _chartValues[7].value),
        generateGroupData(8, _chartValues[8].value),
        generateGroupData(9, _chartValues[9].value),
        generateGroupData(10, _chartValues[10].value),
        generateGroupData(11, _chartValues[11].value),
      ];
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchAllChartValues();
  }

  @override
  Widget build(BuildContext context) {
    final double maxY = getMaxY() + (betweenSpace * 3);
    final double interval = maxY / 5;

    return GlobalVariables.customContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Monthly revenue',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: GlobalVariables.black,
                    ),
                  ),
                  Text(
                    'total monthly revenue of the product',
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
          const SizedBox(height: 8),
          LegendsListWidget(
            legends: [
              Legend('Revenue', GlobalVariables.green),
            ],
          ),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: EdgeInsets.only(top: 16, right: 16),
              width: MediaQuery.of(context).size.width * 1.5,
              child: AspectRatio(
                aspectRatio: 2,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceBetween,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: leftTitles,
                          reservedSize:
                              40, // Increased reserved size for left titles
                          interval: interval, // Adjust the interval dynamically
                        ),
                      ),
                      rightTitles: const AxisTitles(),
                      topTitles: const AxisTitles(),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                          reservedSize: 20,
                        ),
                      ),
                    ),
                    barTouchData: BarTouchData(enabled: false),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    barGroups: barData,
                    maxY: maxY,
                    extraLinesData: ExtraLinesData(
                      horizontalLines: [
                        ...List.generate(
                          (maxY / interval).ceil(),
                          (index) => HorizontalLine(
                            y: interval * index,
                            color: Colors.grey,
                            strokeWidth: 1,
                            dashArray: [5, 5],
                          ),
                        ),
                        HorizontalLine(
                          y: maxY,
                          color: Colors.grey,
                          strokeWidth: 1,
                          dashArray: [5, 5],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
