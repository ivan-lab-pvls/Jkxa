import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartspend_app/router/router.dart';
import 'package:smartspend_app/screens/balance/balance_screen.dart';
import 'package:smartspend_app/screens/calculator/calculator_screen.dart';
import 'package:smartspend_app/screens/news_list/news_list_screen.dart';
import 'package:smartspend_app/screens/settings/settings_screen.dart';
import 'package:smartspend_app/theme/colors.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final _tabs = [BalanceScreen(), CalculatorScreen(), NewsListScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const IconThemeData(color: AppColors.blue);
            } else {
              return const IconThemeData(color: AppColors.iconGrey);
            }
          }),
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue);
            }
            return const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AppColors.iconGrey);
          }),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedIndex: _currentIndex,
          backgroundColor: AppColors.grey,
          indicatorColor: Colors.transparent,
          destinations: [
            NavigationDestination(
              selectedIcon: SvgPicture.asset('assets/images/tab-icons/balance.svg', color: AppColors.blue),
              icon: SvgPicture.asset('assets/images/tab-icons/balance.svg', color: AppColors.iconGrey),
              label: 'Balance',
            ),
            NavigationDestination(
              selectedIcon: SvgPicture.asset('assets/images/tab-icons/calculator.svg', color: AppColors.blue),
              icon: SvgPicture.asset('assets/images/tab-icons/calculator.svg', color: AppColors.iconGrey),
              label: 'Calculator',
            ),
            NavigationDestination(
              selectedIcon: SvgPicture.asset('assets/images/tab-icons/news.svg', color: AppColors.blue),
              icon: SvgPicture.asset('assets/images/tab-icons/news.svg', color: AppColors.iconGrey),
              label: 'News',
            ),
            NavigationDestination(
              selectedIcon: SvgPicture.asset('assets/images/tab-icons/settings.svg', color: AppColors.blue),
              icon: SvgPicture.asset('assets/images/tab-icons/settings.svg', color: AppColors.iconGrey),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
