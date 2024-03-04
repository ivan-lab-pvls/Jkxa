part of 'analytics_bloc.dart';

@immutable
abstract class AnalyticsEvent {}

class GetDayAnalyticsEvent extends AnalyticsEvent {}

class GetWeekAnalyticsEvent extends AnalyticsEvent {}

class GetMonthAnalyticsEvent extends AnalyticsEvent {}

class GetYearAnalyticsEvent extends AnalyticsEvent {}