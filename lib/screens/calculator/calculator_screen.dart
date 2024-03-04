import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smartspend_app/theme/colors.dart';
import 'package:smartspend_app/widgets/action_button_widget.dart';
import 'package:smartspend_app/widgets/app_container.dart';
import 'package:smartspend_app/widgets/textfield_app_widget.dart';

@RoutePage()
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController periodController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController monthlyAccrualsController = TextEditingController();

  double totalAmount = 0;

  double calculateValue(double investmentAmount, int period, double rate,
      double monthlyAccruals) {
    totalAmount = investmentAmount * pow(1 + rate, period/12) +
          monthlyAccruals * (((pow(1 + rate, period/12) - 1) / rate));
    return totalAmount;
  }

  @override
  void dispose() {
    amountController.dispose();
    periodController.dispose();
    rateController.dispose();
    monthlyAccrualsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.headerGrey,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Investment Calculator',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  totalAmount = 0;
                  amountController.clear();
                  periodController.clear();
                  rateController.clear();
                  monthlyAccrualsController.clear();
                });
              },
              child: Text(
                'Reset',
                style: TextStyle(
                  color: AppColors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total amount',
                        style: TextStyle(
                          color: AppColors.darkGrey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${totalAmount.round()}\$',
                        style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                AppContainer(
                  child: Column(
                    children: [
                      TextFieldAppWidget(
                          controller: amountController,
                          hintText: 'Amount',
                          title: 'Investment amount, \$'),
                      SizedBox(height: 15),
                      TextFieldAppWidget(
                          controller: periodController,
                          hintText: 'Period',
                          title: 'Investment period, Years'),
                      SizedBox(height: 15),
                      TextFieldAppWidget(
                          controller: rateController,
                          hintText: 'Percentage',
                          title: 'Rate, % p.a.'),
                      SizedBox(height: 15),
                      TextFieldAppWidget(
                          controller: monthlyAccrualsController,
                          hintText: 'Amount',
                          title: 'Monthly accruals, \$'),
                      SizedBox(height: 35),
                      ActionButtonWidget(
                        text: 'Calculate',
                        width: 350,
                        onTap: () {
                          calculateValue(double.parse(amountController.text),
                              int.parse(periodController.text),
                              double.parse(rateController.text),
                              double.parse(monthlyAccrualsController.text));
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
