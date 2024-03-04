import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartspend_app/screens/analytics/charts_data/day_bar_data.dart';
import 'package:smartspend_app/theme/colors.dart';

class DayChartWidget extends StatelessWidget {
  final List dayData;
  final double maxAmount;

  const DayChartWidget(
      {super.key, required this.dayData, required this.maxAmount});

  @override
  Widget build(BuildContext context) {
    DayBarData dayBarData = DayBarData(
        firstAmount: dayData[0],
        secondAmount: dayData[1],
        thirdAmount: dayData[2],
        fourthAmount: dayData[3],
        fifthAmount: dayData[4],
        sixthAmount: dayData[5],
        seventhAmount: dayData[6],
        eighthAmount: dayData[7],
        ninthAmount: dayData[8],
        tenthAmount: dayData[9],
        eleventhAmount: dayData[10],
        twelfthAmount: dayData[11]);

    dayBarData.initializeDayBarData();

    return Center(
      child: Container(
        height: 350,
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: BarChart(
          BarChartData(
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
                show: true,
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true, getTitlesWidget: getBottomTiles))),
            maxY: 100,
            minY: 0,
            barGroups: dayBarData.dayBarData
                .map(
                  (data) => BarChartGroupData(
                    x: data.x,
                    barRods: [
                      BarChartRodData(
                        toY: data.y <= 0 ? 1 : data.y / maxAmount * 100,
                        color: AppColors.blue,
                        width: 20,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: 100,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const style = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.fontGrey);

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text('12', style: style);
      break;
    case 1:
      text = Text('2', style: style);
      break;
    case 2:
      text = Text('4', style: style);
      break;
    case 3:
      text = Text('6', style: style);
      break;
    case 4:
      text = Text('8', style: style);
      break;
    case 5:
      text = Text('10', style: style);
      break;
    case 6:
      text = Text('12', style: style);
      break;
    case 7:
      text = Text('2', style: style);
      break;
    case 8:
      text = Text('4', style: style);
      break;
    case 9:
      text = Text('6', style: style);
      break;
    case 10:
      text = Text('8', style: style);
      break;
    case 11:
      text = Text('10', style: style);
      break;
    default:
      text = Text('', style: style);
      break;
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
