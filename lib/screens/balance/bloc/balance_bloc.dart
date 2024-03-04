import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smartspend_app/models/bill_model.dart';
import 'package:smartspend_app/services/shared_preferences.dart';

part 'balance_event.dart';

part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc() : super(BalanceInitial()) {
    on<GetSortedBillsEvent>(_getSortedBillsHandler);
    on<AddIncomeBillEvent>(_addIncomeBillHandler);
    on<AddSpendBillEvent>(_addSpendBillHandler);
    on<GetTotalAmountsEvent>(_getTotalAmountsHandler);
    on<ResetEvent>(_resetHandler);
  }

  void _getSortedBillsHandler(
      GetSortedBillsEvent event, Emitter<BalanceState> emit) async {
    SharedPreferencesService storage =
        await SharedPreferencesService.getInstance();

    final List<BillModel> _bills = convertStringListToBillModelList(storage.incomeBills) +
        convertStringListToBillModelList(storage.spendBills);


    _bills.sort((a, b) => a.date.compareTo(b.date));

    emit(LoadedSortedBillsState(bills: _bills.reversed.toList()));

  }

  void _addIncomeBillHandler(
      AddIncomeBillEvent event, Emitter<BalanceState> emit) async {
    SharedPreferencesService storage =
        await SharedPreferencesService.getInstance();
    final String incomeBillString =
        "Value: ${event.incomeBill.value}, Comment: ${event.incomeBill.comment}, Date: ${event.incomeBill.date}, Type: ${event.incomeBill.type}";

    final List<String> _incomeBills = storage.incomeBills;
    _incomeBills.add(incomeBillString);
    storage.incomeBills = _incomeBills;

    storage.totalIncome += event.incomeBill.value;
  }

  void _addSpendBillHandler(
      AddSpendBillEvent event, Emitter<BalanceState> emit) async {
    SharedPreferencesService storage =
        await SharedPreferencesService.getInstance();

    final String spendBillString =
        "Value: ${event.spendBill.value}, Comment: ${event.spendBill.comment}, Date: ${event.spendBill.date}, Type: ${event.spendBill.type}";

    final List<String> _spendBills = storage.spendBills;
    _spendBills.add(spendBillString);
    storage.spendBills = _spendBills;

    storage.totalSpend += event.spendBill.value;
  }

  void _getTotalAmountsHandler(
      GetTotalAmountsEvent event, Emitter<BalanceState> emit) async {
    SharedPreferencesService storage =
        await SharedPreferencesService.getInstance();

    final double _totalAmount = storage.totalIncome + storage.totalSpend;

    emit(LoadedTotalAmountsState(
        totalAmount: _totalAmount,
        income: storage.totalIncome,
        spend: storage.totalSpend));
  }

  void _resetHandler(ResetEvent event, Emitter<BalanceState> emit) async {
    SharedPreferencesService storage =
        await SharedPreferencesService.getInstance();

    storage.totalIncome = 0;
    storage.totalSpend = 0;
    storage.incomeBills = [];
    storage.spendBills = [];
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
}
