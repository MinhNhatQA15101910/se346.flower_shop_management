import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/features/admin/statistic/widgets/legend_widget.dart';

class BarChartSample6 extends StatelessWidget {
  BarChartSample6({super.key});

  final pilateColor = GlobalVariables.lightGreen;
  final cyclingColor = GlobalVariables.lightYellow;
  final quickWorkoutColor = GlobalVariables.lightBlue;
  final betweenSpace = 0.2;

  final List<BarChartGroupData> barData = [
    generateGroupData(0, 2, 3, 2),
    generateGroupData(1, 2, 5, 1.7),
    generateGroupData(2, 1.3, 3.1, 2.8),
    generateGroupData(3, 3.1, 4, 3.1),
    generateGroupData(4, 0.8, 3.3, 3.4),
    generateGroupData(5, 2, 5.6, 1.8),
    generateGroupData(6, 1.3, 3.2, 2),
    generateGroupData(7, 2.3, 3.2, 3),
    generateGroupData(8, 2, 4.8, 2.5),
    generateGroupData(9, 1.2, 3.2, 2.5),
    generateGroupData(10, 1, 4.8, 3),
    generateGroupData(11, 2, 4.4, 2.8),
  ];

  static BarChartGroupData generateGroupData(
    int x,
    double pilates,
    double quickWorkout,
    double cycling,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: pilates,
          color: GlobalVariables.green,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + 0.2,
          toY: pilates + 0.2 + quickWorkout,
          color: GlobalVariables.darkBlue,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + 0.2 + quickWorkout + 0.2,
          toY: pilates + 0.2 + quickWorkout + 0.2 + cycling,
          color: GlobalVariables.yellow,
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

  @override
  Widget build(BuildContext context) {
    final double maxY = getMaxY() + (betweenSpace * 3);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Activity',
            style: TextStyle(
              color: GlobalVariables.lightBlue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          LegendsListWidget(
            legends: [
              Legend('Pilates', GlobalVariables.green),
              Legend('Quick workouts', GlobalVariables.darkBlue),
              Legend('Cycling', GlobalVariables.yellow),
            ],
          ),
          const SizedBox(height: 14),
          AspectRatio(
            aspectRatio: 2,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: leftTitles,
                      reservedSize: 28,
                      interval: maxY / 5, // Adjust the interval dynamically
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
                    HorizontalLine(
                      y: maxY / 3,
                      color: pilateColor,
                      strokeWidth: 1,
                      dashArray: [20, 4],
                    ),
                    HorizontalLine(
                      y: (maxY / 3) * 2,
                      color: quickWorkoutColor,
                      strokeWidth: 1,
                      dashArray: [20, 4],
                    ),
                    HorizontalLine(
                      y: maxY,
                      color: cyclingColor,
                      strokeWidth: 1,
                      dashArray: [20, 4],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
