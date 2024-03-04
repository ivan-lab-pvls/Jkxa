// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddIncomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddIncomeScreen(),
      );
    },
    AddSpendRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddSpendScreen(),
      );
    },
    AnalyticsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AnalyticsScreen(),
      );
    },
    BalanceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BalanceScreen(),
      );
    },
    CalculatorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CalculatorScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    NewsInfoRoute.name: (routeData) {
      final args = routeData.argsAs<NewsInfoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NewsInfoScreen(
          key: args.key,
          news: args.news,
        ),
      );
    },
    NewsListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewsListScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
  };
}

/// generated route for
/// [AddIncomeScreen]
class AddIncomeRoute extends PageRouteInfo<void> {
  const AddIncomeRoute({List<PageRouteInfo>? children})
      : super(
          AddIncomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddIncomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddSpendScreen]
class AddSpendRoute extends PageRouteInfo<void> {
  const AddSpendRoute({List<PageRouteInfo>? children})
      : super(
          AddSpendRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddSpendRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AnalyticsScreen]
class AnalyticsRoute extends PageRouteInfo<void> {
  const AnalyticsRoute({List<PageRouteInfo>? children})
      : super(
          AnalyticsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AnalyticsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BalanceScreen]
class BalanceRoute extends PageRouteInfo<void> {
  const BalanceRoute({List<PageRouteInfo>? children})
      : super(
          BalanceRoute.name,
          initialChildren: children,
        );

  static const String name = 'BalanceRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CalculatorScreen]
class CalculatorRoute extends PageRouteInfo<void> {
  const CalculatorRoute({List<PageRouteInfo>? children})
      : super(
          CalculatorRoute.name,
          initialChildren: children,
        );

  static const String name = 'CalculatorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewsInfoScreen]
class NewsInfoRoute extends PageRouteInfo<NewsInfoRouteArgs> {
  NewsInfoRoute({
    Key? key,
    required NewsModel news,
    List<PageRouteInfo>? children,
  }) : super(
          NewsInfoRoute.name,
          args: NewsInfoRouteArgs(
            key: key,
            news: news,
          ),
          initialChildren: children,
        );

  static const String name = 'NewsInfoRoute';

  static const PageInfo<NewsInfoRouteArgs> page =
      PageInfo<NewsInfoRouteArgs>(name);
}

class NewsInfoRouteArgs {
  const NewsInfoRouteArgs({
    this.key,
    required this.news,
  });

  final Key? key;

  final NewsModel news;

  @override
  String toString() {
    return 'NewsInfoRouteArgs{key: $key, news: $news}';
  }
}

/// generated route for
/// [NewsListScreen]
class NewsListRoute extends PageRouteInfo<void> {
  const NewsListRoute({List<PageRouteInfo>? children})
      : super(
          NewsListRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewsListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
