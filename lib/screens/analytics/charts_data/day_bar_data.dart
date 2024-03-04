
import 'package:smartspend_app/screens/analytics/models/individual_bar.dart';

class DayBarData {
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

  DayBarData(
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
        required this.twelfthAmount});

  List<IndividualBar> dayBarData = [];

  void initializeDayBarData() {
    dayBarData = [
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
    ];
  }
}