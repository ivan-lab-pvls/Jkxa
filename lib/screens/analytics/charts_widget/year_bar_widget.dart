import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartspend_app/screens/analytics/charts_data/year_bar_data.dart';
import 'package:smartspend_app/theme/colors.dart';

class YearChartWidget extends StatelessWidget {
  final List yearData;
  final double maxAmount;

  const YearChartWidget({super.key, required this.yearData, required this.maxAmount});

  @override
  Widget build(BuildContext context) {
    YearBarData yearBarData = YearBarData(
        firstAmount: yearData[0],
        secondAmount: yearData[1],
        thirdAmount: yearData[2],
        fourthAmount: yearData[3],
        fifthAmount: yearData[4],
        sixthAmount: yearData[5],
        seventhAmount: yearData[6],
        eighthAmount: yearData[7],
        ninthAmount: yearData[8],
        tenthAmount: yearData[9],
        eleventhAmount: yearData[10],
        twelfthAmount: yearData[11]);

    yearBarData.initializeYearBarData();

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
            barGroups: yearBarData.yearBarData
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
                    ),),
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
      text = Text('Jan', style: style);
      break;
    case 1:
      text = Text('Feb', style: style);
      break;
    case 2:
      text = Text('Mar', style: style);
      break;
    case 3:
      text = Text('Apr', style: style);
      break;
    case 4:
      text = Text('May', style: style);
      break;
    case 5:
      text = Text('Jun', style: style);
      break;
    case 6:
      text = Text('Jul', style: style);
      break;
    case 7:
      text = Text('Aug', style: style);
      break;
    case 8:
      text = Text('Sep', style: style);
      break;
    case 9:
      text = Text('Oct', style: style);
      break;
    case 10:
      text = Text('Nov', style: style);
      break;
    case 11:
      text = Text('Dec', style: style);
      break;
    default:
      text = Text('', style: style);
      break;
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}