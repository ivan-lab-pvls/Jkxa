import 'package:smartspend_app/screens/analytics/models/individual_bar.dart';

class WeekBarData {
  final double mondayAmount;
  final double tuesdayAmount;
  final double wednesdayAmount;
  final double thursdayAmount;
  final double fridayAmount;
  final double saturdayAmount;
  final double sundayAmount;

  WeekBarData(
      {required this.mondayAmount,
        required this.tuesdayAmount,
        required this.wednesdayAmount,
        required this.thursdayAmount,
        required this.fridayAmount,
        required this.saturdayAmount,
        required this.sundayAmount});

  List<IndividualBar> weekBarData = [];

  void initializeWeekBarData() {
    weekBarData = [
      IndividualBar(x: 0, y: mondayAmount),
      IndividualBar(x: 1, y: tuesdayAmount),
      IndividualBar(x: 2, y: wednesdayAmount),
      IndividualBar(x: 3, y: thursdayAmount),
      IndividualBar(x: 4, y: fridayAmount),
      IndividualBar(x: 5, y: saturdayAmount),
      IndividualBar(x: 6, y: sundayAmount),
    ];
  }
}
