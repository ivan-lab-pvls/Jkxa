import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:smartspend_app/models/bill_model.dart';
import 'package:smartspend_app/services/shared_preferences.dart';

part 'analytics_event.dart';

part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc() : super(AnalyticsInitial()) {
    on<GetDayAnalyticsEvent>(_getDayAnalyticsHandler);
    on<GetWeekAnalyticsEvent>(_getWeekAnalyticsHandler);
    on<GetMonthAnalyticsEvent>(_getMonthAnalyticsHandler);
    on<GetYearAnalyticsEvent>(_getYearAnalyticsHandler);
  }

  void _getDayAnalyticsHandler(
      GetDayAnalyticsEvent event, Emitter<AnalyticsState> emit) async {
    SharedPreferencesService storage =
    await SharedPreferencesService.getInstance();

    final List<BillModel> _incomeBills =
    convertStringListToBillModelList(storage.incomeBills);
    final List<BillModel> _spendBills =
    convertStringListToBillModelList(storage.spendBills);

    final List<double> _dayData = calculateDailyDifference(_incomeBills, _spendBills);

    final double _maxIncome = _dayData[0];
    final double _totalIncome = _dayData[1];
    final double _totalSpend = _dayData[2];
    final List<double> _dayAnalytics = _dayData.sublist(3);

    emit(LoadedDayAnalyticsState(
        dayAnalytics: _dayAnalytics,
        maxIncome: _maxIncome,
        totalIncome: _totalIncome,
        totalSpend: _totalSpend));
  }

  void _getWeekAnalyticsHandler(
      GetWeekAnalyticsEvent event, Emitter<AnalyticsState> emit) async {
    SharedPreferencesService storage =
    await SharedPreferencesService.getInstance();

    final List<BillModel> _incomeBills =
    convertStringListToBillModelList(storage.incomeBills);
    final List<BillModel> _spendBills =
    convertStringListToBillModelList(storage.spendBills);

    final List<double> _weekData = calculateWeeklyDifference(_incomeBills, _spendBills);

    final double _maxIncome = _weekData[0];
    final double _totalIncome = _weekData[1];
    final double _totalSpend = _weekData[2];
    final List<double> _weekAnalytics = _weekData.sublist(3);

    emit(LoadedWeekAnalyticsState(
        weekAnalytics: _weekAnalytics,
        maxIncome: _maxIncome,
        totalIncome: _totalIncome,
        totalSpend: _totalSpend));
  }

  void _getMonthAnalyticsHandler(
      GetMonthAnalyticsEvent event, Emitter<AnalyticsState> emit) async {
    SharedPreferencesService storage =
    await SharedPreferencesService.getInstance();

    final List<BillModel> _incomeBills =
    convertStringListToBillModelList(storage.incomeBills);
    final List<BillModel> _spendBills =
    convertStringListToBillModelList(storage.spendBills);

    final List<double> _monthData = calculateMonthlyDifference(_incomeBills, _spendBills);

    final double _maxIncome = _monthData[0];
    final double _totalIncome = _monthData[1];
    final double _totalSpend = _monthData[2];
    final List<double> _monthAnalytics = _monthData.sublist(3);

    emit(LoadedMonthAnalyticsState(
        monthAnalytics: _monthAnalytics,
        maxIncome: _maxIncome,
        totalIncome: _totalIncome,
        totalSpend: _totalSpend));
  }

  void _getYearAnalyticsHandler(
      GetYearAnalyticsEvent event, Emitter<AnalyticsState> emit) async {
    SharedPreferencesService storage =
    await SharedPreferencesService.getInstance();

    final List<BillModel> _incomeBills =
    convertStringListToBillModelList(storage.incomeBills);
    final List<BillModel> _spendBills =
    convertStringListToBillModelList(storage.spendBills);

    final List<double> _yearData = calculateYearlyDifference(_incomeBills, _spendBills);

    final double _maxIncome = _yearData[0];
    final double _totalIncome = _yearData[1];
    final double _totalSpend = _yearData[2];
    final List<double> _yearAnalytics = _yearData.sublist(3);

    emit(LoadedYearAnalyticsState(
        yearAnalytics: _yearAnalytics,
        maxIncome: _maxIncome,
        totalIncome: _totalIncome,
        totalSpend: _totalSpend));
  }

  List<BillModel> convertStringListToBillModelList(List<String> stringList) {
    List<BillModel> billModels = [];
    for (String billString in stringList) {
      List<String> parts = billString.split(', ');

      double value = double.parse(parts[0].split(': ')[1]);
      String comment = parts[1].split(': ')[1];
      DateTime date = DateTime.parse(parts[2].split(': ')[1]);
      String type = parts[3].split(': ')[1];

      BillModel billModel =
      BillModel(value: value, comment: comment, date: date, type: type);
      billModels.add(billModel);
    }
    return billModels;
  }

  List<double> calculateDailyDifference(List<BillModel> incomeBills, List<BillModel> spendBills) {
    List<double> dailyDifferences = [];
    DateTime now = DateTime.now();
    double maxDifference = 0;
    double totalIncome = 0;
    double totalSpend = 0;

    for (int i = 0; i < 12; i++) {
      DateTime dayStart = now.subtract(Duration(hours: 24 - i*2));
      DateTime dayEnd = now.subtract(Duration(hours: 24 - i*2 - 2));

      double incomeTotal = 0;
      double spendTotal = 0;

      for (var bill in incomeBills) {
        if (bill.date.isAfter(dayStart) && bill.date.isBefore(dayEnd)) {
          incomeTotal += bill.value;
        }
      }

      for (var bill in spendBills) {
        if (bill.date.isAfter(dayStart) && bill.date.isBefore(dayEnd)) {
          spendTotal += bill.value;
        }
      }

      double difference = incomeTotal - spendTotal;
      dailyDifferences.add(difference);

      if (difference > maxDifference) {
        maxDifference = difference;
      }

      totalIncome += incomeTotal;
      totalSpend += spendTotal;
    }

    dailyDifferences.insert(0, maxDifference);
    dailyDifferences.insert(1, totalIncome);
    dailyDifferences.insert(2, totalSpend);

    return dailyDifferences;
  }

  List<double> calculateWeeklyDifference(List<BillModel> incomeBills, List<BillModel> spendBills) {
    List<double> weeklyDifferences = [];
    DateTime now = DateTime.now();
    double maxDifference = 0;
    double totalIncome = 0;
    double totalSpend = 0;

    for (int i = 0; i < 7; i++) {
      DateTime weekStart = now.subtract(Duration(days: 7 - i));
      DateTime weekEnd = now.subtract(Duration(days: 7 - i - 1));

      double incomeTotal = 0;
      double spendTotal = 0;

      for (var bill in incomeBills) {
        if (bill.date.isAfter(weekStart) && bill.date.isBefore(weekEnd)) {
          incomeTotal += bill.value;
        }
      }

      for (var bill in spendBills) {
        if (bill.date.isAfter(weekStart) && bill.date.isBefore(weekEnd)) {
          spendTotal += bill.value;
        }
      }

      double difference = incomeTotal - spendTotal;
      weeklyDifferences.add(difference);

      if (difference > maxDifference) {
        maxDifference = difference;
      }

      totalIncome += incomeTotal;
      totalSpend += spendTotal;
    }

    weeklyDifferences.insert(0, maxDifference);
    weeklyDifferences.insert(1, totalIncome);
    weeklyDifferences.insert(2, totalSpend);

    return weeklyDifferences;
  }

  List<double> calculateMonthlyDifference(List<BillModel> incomeBills, List<BillModel> spendBills) {
    List<double> monthlyDifferences = [];
    DateTime now = DateTime.now();
    double maxDifference = 0;
    double totalIncome = 0;
    double totalSpend = 0;

    for (int i = 0; i < 31; i++) {
      DateTime monthStart = now.subtract(Duration(days: 30 - i));
      DateTime monthEnd = now.subtract(Duration(days: 30 - i - 1));

      double incomeTotal = 0;
      double spendTotal = 0;

      for (var bill in incomeBills) {
        if (bill.date.isAfter(monthStart) && bill.date.isBefore(monthEnd)) {
          incomeTotal += bill.value;
        }
      }

      for (var bill in spendBills) {
        if (bill.date.isAfter(monthStart) && bill.date.isBefore(monthEnd)) {
          spendTotal += bill.value;
        }
      }

      double difference = incomeTotal - spendTotal;
      monthlyDifferences.add(difference);

      if (difference > maxDifference) {
        maxDifference = difference;
      }

      totalIncome += incomeTotal;
      totalSpend += spendTotal;
    }

    monthlyDifferences.insert(0, maxDifference);
    monthlyDifferences.insert(1, totalIncome);
    monthlyDifferences.insert(2, totalSpend);

    return monthlyDifferences;
  }

  List<double> calculateYearlyDifference(List<BillModel> incomeBills, List<BillModel> spendBills) {
    List<double> yearlyDifferences = [];
    DateTime now = DateTime.now();
    double maxDifference = 0;
    double totalIncome = 0;
    double totalSpend = 0;

    for (int i = 0; i < 12; i++) {
      DateTime yearStart = now.subtract(Duration(days: 365 - i * 31));
      DateTime yearEnd = now.subtract(Duration(days: 365 - i * 31 - 31));

      double incomeTotal = 0;
      double spendTotal = 0;

      for (var bill in incomeBills) {
        if (bill.date.isAfter(yearStart) && bill.date.isBefore(yearEnd)) {
          incomeTotal += bill.value;
        }
      }

      for (var bill in spendBills) {
        if (bill.date.isAfter(yearStart) && bill.date.isBefore(yearEnd)) {
          spendTotal += bill.value;
        }
      }

      double difference = incomeTotal - spendTotal;
      yearlyDifferences.add(difference);

      if (difference > maxDifference) {
        maxDifference = difference;
      }

      totalIncome += incomeTotal;
      totalSpend += spendTotal;
    }

    yearlyDifferences.insert(0, maxDifference);
    yearlyDifferences.insert(1, totalIncome);
    yearlyDifferences.insert(2, totalSpend);

    return yearlyDifferences;
  }
}