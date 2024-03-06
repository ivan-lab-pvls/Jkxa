import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartspend_app/models/bill_model.dart';
import 'package:smartspend_app/screens/analytics/analytics_screen.dart';
import 'package:smartspend_app/screens/balance/add/add_income_screen.dart';
import 'package:smartspend_app/screens/balance/add/add_spend_screen.dart';
import 'package:smartspend_app/screens/balance/bloc/balance_bloc.dart';
import 'package:smartspend_app/screens/balance/widgets/header_widget.dart';
import 'package:smartspend_app/theme/colors.dart';
import 'package:smartspend_app/widgets/app_container.dart';

@RoutePage()
class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  List<BillModel> _bills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              HeaderWidget(),
              SizedBox(height: 10),
              AppContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) =>
                              CupertinoActionSheet(
                            message: const Text('What you want to add?'),
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const AddIncomeScreen()));
                                },
                                child: const Text('Add Income'),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const AddSpendScreen()));
                                },
                                child: const Text('Add Expense'),
                              ),
                              CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        width: 180,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/images/balance/plus.svg'),
                            SizedBox(height: 5),
                            Text(
                              'Refill Balance',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const AnalyticsScreen()));
                      },
                      child: Container(
                        width: 180,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                                'assets/images/balance/static.svg'),
                            SizedBox(height: 5),
                            Text(
                              'Activities',
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              BlocProvider(
                create: (context) => BalanceBloc()..add(GetSortedBillsEvent()),
                child: BlocConsumer<BalanceBloc, BalanceState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is LoadedSortedBillsState) {
                      if (state.bills.isNotEmpty) {
                        return AppContainer(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'History',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showCupertinoModalPopup<void>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CupertinoActionSheet(
                                          message: const Text('Sort'),
                                          actions: <CupertinoActionSheetAction>[
                                            CupertinoActionSheetAction(
                                              onPressed: () {
                                                setState(() {
                                                  _bills = state.bills;
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: const Text('All'),
                                            ),
                                            CupertinoActionSheetAction(
                                              onPressed: () {
                                                setState(() {
                                                  _bills = state.bills
                                                      .where((bill) =>
                                                          bill.value > 0)
                                                      .toList();
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: const Text('By Income'),
                                            ),
                                            CupertinoActionSheetAction(
                                              onPressed: () {
                                                setState(() {
                                                  _bills = state.bills
                                                      .where((bill) =>
                                                          bill.value < 0)
                                                      .toList();
                                                });
                                                Navigator.pop(context);
                                              },
                                              child: const Text('By Expense'),
                                            ),
                                            CupertinoActionSheetAction(
                                              isDestructiveAction: true,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancel'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: SvgPicture.asset(
                                        'assets/images/balance/sort.svg'),
                                  ),
                                ],
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(vertical: 16),
                                itemCount: _bills.isNotEmpty
                                    ? _bills.length
                                    : state.bills.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(height: 15),
                                itemBuilder: (BuildContext context, int index) {
                                  BillModel bill;
                                  if (_bills.isNotEmpty) {
                                    bill = _bills[index];
                                  } else {
                                    bill = state.bills[index];
                                  }
                                  return Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: AppColors.grey,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.0))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              bill.comment,
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                bill.value < 0
                                                    ? SvgPicture.asset(
                                                        'assets/images/balance/spend-card.svg')
                                                    : SvgPicture.asset(
                                                        'assets/images/balance/income-card.svg'),
                                                SizedBox(width: 5),
                                                Text(
                                                  bill.type,
                                                  style: TextStyle(
                                                    color: AppColors.darkGrey,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${bill.value.toStringAsFixed(1)} \$',
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return AppContainer(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'History',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: SvgPicture.asset(
                                        'assets/images/balance/sort.svg'),
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                              Container(
                                width: 255,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: AppColors.grey,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(16.0))),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/balance/info.svg'),
                                        SizedBox(width: 5),
                                        Text(
                                          'Your balance is empty.',
                                          style: TextStyle(
                                            color: AppColors.fontGrey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'To add income or expenses, tap to the add button.',
                                      style: TextStyle(
                                        color: AppColors.fontGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 70),
                            ],
                          ),
                        );
                      }
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
