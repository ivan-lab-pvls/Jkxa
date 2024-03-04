
import 'package:smartspend_app/screens/analytics/models/individual_bar.dart';

class MonthBarData {
  final double firstAmount;
  final double secondAmount;
  final double thirdAmount;
  final double fourthAmount;
  final double fifthAmount;
  final double sixthAmount;
  final double seventhAmount;
  final double eighthAmount;
  final double ninthAmount;
  final double tenthAmount;
  final double eleventhAmount;
  final double twelfthAmount;
  final double thirteenthAmount;
  final double fourteenthAmount;
  final double fifteenthAmount;
  final double sixteenthAmount;
  final double seventeenthAmount;
  final double eighteenthAmount;
  final double nineteenthAmount;
  final double twentiethAmount;
  final double twentyFirstAmount;
  final double twentySecondAmount;
  final double twentyThirdAmount;
  final double twentyFourthAmount;
  final double twentyFifthAmount;
  final double twentySixthAmount;
  final double twentySeventhAmount;
  final double twentyEighthAmount;
  final double twentyNinthAmount;
  final double thirtiethAmount;
  final double thirtyFirstAmount;

  MonthBarData(
      {required this.firstAmount,
        required this.secondAmount,
        required this.thirdAmount,
        required this.fourthAmount,
        required this.fifthAmount,
        required this.sixthAmount,
        required this.seventhAmount,
        required this.eighthAmount,
        required this.ninthAmount,
        required this.tenthAmount,
        required this.eleventhAmount,
        required this.twelfthAmount,
        required this.thirteenthAmount,
        required this.fourteenthAmount,
        required this.fifteenthAmount,
        required this.sixteenthAmount,
        required this.seventeenthAmount,
        required this.eighteenthAmount,
        required this.nineteenthAmount,
        required this.twentiethAmount,
        required this.twentyFirstAmount,
        required this.twentySecondAmount,
        required this.twentyThirdAmount,
        required this.twentyFourthAmount,
        required this.twentyFifthAmount,
        required this.twentySixthAmount,
        required this.twentySeventhAmount,
        required this.twentyEighthAmount,
        required this.twentyNinthAmount,
        required this.thirtiethAmount,
        required this.thirtyFirstAmount});

  List<IndividualBar> monthBarData = [];

  void initializeMonthBarData() {
    monthBarData = [
      IndividualBar(x: 0, y: firstAmount),
      IndividualBar(x: 1, y: secondAmount),
      IndividualBar(x: 2, y: thirdAmount),
      IndividualBar(x: 3, y: fourthAmount),
      IndividualBar(x: 4, y: fifthAmount),
      IndividualBar(x: 5, y: sixthAmount),
      IndividualBar(x: 6, y: seventhAmount),
      IndividualBar(x: 7, y: eighthAmount),
      IndividualBar(x: 8, y: ninthAmount),
      IndividualBar(x: 9, y: tenthAmount),
      IndividualBar(x: 10, y: eleventhAmount),
      IndividualBar(x: 11, y: twelfthAmount),
      IndividualBar(x: 12, y: thirteenthAmount),
      IndividualBar(x: 13, y: fourteenthAmount),
      IndividualBar(x: 14, y: fifteenthAmount),
      IndividualBar(x: 15, y: sixteenthAmount),
      IndividualBar(x: 16, y: seventeenthAmount),
      IndividualBar(x: 17, y: eighteenthAmount),
      IndividualBar(x: 18, y: nineteenthAmount),
      IndividualBar(x: 19, y: twentiethAmount),
      IndividualBar(x: 20, y: twentyFirstAmount),
      IndividualBar(x: 21, y: twentySecondAmount),
      IndividualBar(x: 22, y: twentyThirdAmount),
      IndividualBar(x: 23, y: twentyFourthAmount),
      IndividualBar(x: 24, y: twentyFifthAmount),
      IndividualBar(x: 25, y: twentySixthAmount),
      IndividualBar(x: 26, y: twentySeventhAmount),
      IndividualBar(x: 27, y: twentyEighthAmount),
      IndividualBar(x: 28, y: twentyNinthAmount),
      IndividualBar(x: 29, y: thirtiethAmount),
      IndividualBar(x: 30, y: thirtyFirstAmount),
    ];
  }
}
