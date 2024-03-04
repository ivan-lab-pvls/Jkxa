
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartspend_app/screens/analytics/bloc/analytics_bloc.dart';
import 'package:smartspend_app/screens/analytics/charts_widget/day_bar_widget.dart';
import 'package:smartspend_app/theme/colors.dart';
import 'package:smartspend_app/widgets/app_container.dart';

class DayTab extends StatefulWidget {
  const DayTab({super.key});

  @override
  State<DayTab> createState() => _DayTabState();
}

class _DayTabState extends State<DayTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      body: BlocProvider(
        create: (context) => AnalyticsBloc()..add(GetDayAnalyticsEvent()),
        child: BlocConsumer<AnalyticsBloc, AnalyticsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadedDayAnalyticsState) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: [
                    AppContainer(child: DayChartWidget(dayData: state.dayAnalytics, maxAmount: state.maxIncome)),
                    SizedBox(height: 25),
                    AppContainer(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                                color: AppColors.grey,
                                border: Border.all(color: Colors.transparent),
                                borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total amount',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${state.totalIncome + state.totalSpend} \$',
                                  style: TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.grey,
                                border: Border.all(color: Colors.transparent),
                                borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Income',
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${state.totalIncome} \$',
                                        style: TextStyle(
                                          color: AppColors.darkGrey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(color: AppColors.white, height: 2,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Expenses',
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${state.totalSpend} \$',
                                        style: TextStyle(
                                          color: AppColors.darkGrey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
