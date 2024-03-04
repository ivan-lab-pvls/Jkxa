part of 'balance_bloc.dart';

@immutable
abstract class BalanceEvent {}

class GetSortedBillsEvent extends BalanceEvent {}

class AddIncomeBillEvent extends BalanceEvent {
  final BillModel incomeBill;

  AddIncomeBillEvent({required this.incomeBill});
}

class AddSpendBillEvent extends BalanceEvent {
  final BillModel spendBill;

  AddSpendBillEvent({required this.spendBill});
}

class GetTotalAmountsEvent extends BalanceEvent {}

class ResetEvent extends BalanceEvent {}