import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smartspend_app/screens/analytics/tabs/day_tab.dart';
import 'package:smartspend_app/screens/analytics/tabs/month_tab.dart';
import 'package:smartspend_app/screens/analytics/tabs/week_tab.dart';
import 'package:smartspend_app/screens/analytics/tabs/year_tab.dart';
import 'package:smartspend_app/theme/colors.dart';

@RoutePage()
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.grey,
        appBar: AppBar(
            bottom: TabBar(
              dividerColor: AppColors.headerGrey,
              indicatorColor: AppColors.black,
              labelColor: AppColors.black,
              unselectedLabelColor: AppColors.fontGrey,
              tabs: [
                Tab(child: Text('Today', style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),)),
                Tab(child: Text('Week', style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),)),
                Tab(child: Text('Month', style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),)),
                Tab(child: Text('Year', style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16),)),
              ],
            ),
            elevation: 0,
            backgroundColor: AppColors.headerGrey,
            centerTitle: true,
            title: Text('Activities', style: TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),)
        ),
        body: TabBarView(
          children: [
            DayTab(),
            WeekTab(),
            MonthTab(),
            YearTab(),
          ],
        ),
      ),
    );
  }
}
