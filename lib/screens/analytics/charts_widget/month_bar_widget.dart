import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartspend_app/screens/analytics/charts_data/month_bar_data.dart';
import 'package:smartspend_app/theme/colors.dart';

class MonthChartWidget extends StatelessWidget {
  final List monthData;
  final double maxAmount;

  const MonthChartWidget(
      {super.key, required this.monthData, required this.maxAmount});

  @override
  Widget build(BuildContext context) {
    MonthBarData monthBarData = MonthBarData(
        firstAmount: monthData[0],
        secondAmount: monthData[1],
        thirdAmount: monthData[2],
        fourthAmount: monthData[3],
        fifthAmount: monthData[4],
        sixthAmount: monthData[5],
        seventhAmount: monthData[6],
        eighthAmount: monthData[7],
        ninthAmount: monthData[8],
        tenthAmount: monthData[9],
        eleventhAmount: monthData[10],
        twelfthAmount: monthData[11],
        thirteenthAmount: monthData[12],
        fourteenthAmount: monthData[13],
        fifteenthAmount: monthData[14],
        sixteenthAmount: monthData[15],
        seventeenthAmount: monthData[16],
        eighteenthAmount: monthData[17],
        nineteenthAmount: monthData[18],
        twentiethAmount: monthData[19],
        twentyFirstAmount: monthData[20],
        twentySecondAmount: monthData[21],
        twentyThirdAmount: monthData[22],
        twentyFourthAmount: monthData[23],
        twentyFifthAmount: monthData[24],
        twentySixthAmount: monthData[25],
        twentySeventhAmount: monthData[26],
        twentyEighthAmount: monthData[27],
        twentyNinthAmount: monthData[28],
        thirtiethAmount: monthData[29],
        thirtyFirstAmount: monthData[30]);

    monthBarData.initializeMonthBarData();

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
            titlesData: FlTitlesData(show: false),
            maxY: 100,
            minY: 0,
            barGroups: monthBarData.monthBarData
                .map(
                  (data) => BarChartGroupData(
                    x: data.x,
                    barRods: [
                      BarChartRodData(
                        toY: data.y <= 0 ? 1 : data.y / maxAmount * 100,
                        color: AppColors.blue,
                        width: 8,
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
