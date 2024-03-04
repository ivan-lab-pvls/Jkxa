import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartspend_app/screens/balance/bloc/balance_bloc.dart';
import 'package:smartspend_app/theme/colors.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.headerGrey,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(16.0),
          bottomLeft: Radius.circular(16.0),
        ),
      ),
      child: BlocProvider(
        create: (context) => BalanceBloc()..add(GetTotalAmountsEvent()),
        child: BlocConsumer<BalanceBloc, BalanceState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadedTotalAmountsState) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total amount',
                            style: TextStyle(
                              color: AppColors.fontGrey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${state.totalAmount.toStringAsFixed(1)} \$',
                            style: TextStyle(
                              color: state.totalAmount > 0 ? AppColors.black : AppColors.fontGrey,
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 180,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                'Income',
                                style: TextStyle(
                                  color: AppColors.fontGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/balance/income.svg'),
                                  SizedBox(width: 5),
                                  Text(
                                    '${state.income.toStringAsFixed(1)} \$',
                                    style: TextStyle(
                                      color: state.income > 0 ? AppColors.black : AppColors.fontGrey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              Text(
                                'Expense',
                                style: TextStyle(
                                  color: AppColors.fontGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/balance/spend.svg'),
                                  SizedBox(width: 5),
                                  Text(
                                    '${state.spend.toStringAsFixed(1)} \$',
                                    style: TextStyle(
                                      color: state.spend == 0 ? AppColors.fontGrey : AppColors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
