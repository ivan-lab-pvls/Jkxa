part of 'balance_bloc.dart';

@immutable
abstract class BalanceState {}

class BalanceInitial extends BalanceState {}

class LoadedSortedBillsState extends BalanceState {
  final List<BillModel> bills;

  LoadedSortedBillsState({required this.bills});
}

class LoadedTotalAmountsState extends BalanceState {
  final double totalAmount;
  final double income;
  final double spend;

  LoadedTotalAmountsState(
      {required this.totalAmount, required this.income, required this.spend});
}
