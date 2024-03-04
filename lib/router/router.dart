import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:smartspend_app/screens/analytics/analytics_screen.dart';
import 'package:smartspend_app/screens/balance/add/add_income_screen.dart';
import 'package:smartspend_app/screens/balance/add/add_spend_screen.dart';
import 'package:smartspend_app/screens/balance/balance_screen.dart';
import 'package:smartspend_app/screens/calculator/calculator_screen.dart';
import 'package:smartspend_app/screens/main/main_screen.dart';
import 'package:smartspend_app/screens/news_list/news_info_screen.dart';
import 'package:smartspend_app/models/news_model.dart';
import 'package:smartspend_app/screens/news_list/news_list_screen.dart';
import 'package:smartspend_app/screens/onboarding/onboarding_screen.dart';
import 'package:smartspend_app/screens/settings/settings_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardingRoute.page, initial: true),
    AutoRoute(page: MainRoute.page),
    AutoRoute(page: BalanceRoute.page),
    AutoRoute(page: CalculatorRoute.page),
    AutoRoute(page: NewsListRoute.page),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: NewsInfoRoute.page),
    AutoRoute(page: AddIncomeRoute.page),
    AutoRoute(page: AddSpendRoute.page),
    AutoRoute(page: AnalyticsRoute.page),
  ];
}