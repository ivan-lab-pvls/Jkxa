part of 'analytics_bloc.dart';

@immutable
abstract class AnalyticsState {}

class AnalyticsInitial extends AnalyticsState {}

class LoadedDayAnalyticsState extends AnalyticsState {
  final List<double> dayAnalytics;
  final double maxIncome;
  final double totalIncome;
  final double totalSpend;

  LoadedDayAnalyticsState(
      {required this.dayAnalytics,
        required this.maxIncome,
        required this.totalIncome,
        required this.totalSpend});
}

class LoadedWeekAnalyticsState extends AnalyticsState {
  final List<double> weekAnalytics;
  final double maxIncome;
  final double totalIncome;
  final double totalSpend;

  LoadedWeekAnalyticsState(
      {required this.weekAnalytics,
        required this.maxIncome,
        required this.totalIncome,
        required this.totalSpend});
}

class LoadedMonthAnalyticsState extends AnalyticsState {
  final List<double> monthAnalytics;
  final double maxIncome;
  final double totalIncome;
  final double totalSpend;

  LoadedMonthAnalyticsState(
      {required this.monthAnalytics,
        required this.maxIncome,
        required this.totalIncome,
        required this.totalSpend});
}

class LoadedYearAnalyticsState extends AnalyticsState {
  final List<double> yearAnalytics;
  final double maxIncome;
  final double totalIncome;
  final double totalSpend;

  LoadedYearAnalyticsState(
      {required this.yearAnalytics,
        required this.maxIncome,
        required this.totalIncome,
        required this.totalSpend});
}