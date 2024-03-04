import 'package:auto_route/auto_route.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartspend_app/models/bill_model.dart';
import 'package:smartspend_app/router/router.dart';
import 'package:smartspend_app/screens/balance/bloc/balance_bloc.dart';
import 'package:smartspend_app/theme/colors.dart';
import 'package:smartspend_app/widgets/action_button_widget.dart';
import 'package:smartspend_app/widgets/app_container.dart';
import 'package:smartspend_app/widgets/textfield_app_widget.dart';

@RoutePage()
class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  int _currentIndex = 0;

  final List<String> _categories = [
    'Wage',
    'Investments',
    'Rent',
    'Profit',
    'Royalty',
  ];

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.headerGrey,
        centerTitle: true,
        title: Text(
          'Add Income',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        child: AppContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldAppWidget(
                  controller: nameController,
                  hintText: 'Name title',
                  title: 'Title'),
              SizedBox(height: 15),
              TextFieldAppWidget(
                  controller: amountController,
                  hintText: 'Amount',
                  title: 'Amount'),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Category',
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 5),
              ChipList(
                inactiveBorderColorList: [Colors.transparent],
                activeBorderColorList: [Colors.transparent],
                listOfChipNames: _categories,
                activeBgColorList: [AppColors.blue],
                inactiveBgColorList: const [AppColors.grey],
                activeTextColorList: const [AppColors.white],
                inactiveTextColorList: [AppColors.darkGrey],
                borderRadiiList: [100],
                checkmarkColor: AppColors.white,
                shouldWrap: true,
                listOfChipIndicesCurrentlySeclected: [_currentIndex],
                extraOnToggle: (val) {
                  _currentIndex = val;
                  setState(() {});
                },
              ),
              SizedBox(height: 15),
              ActionButtonWidget(
                text: 'Add Income',
                width: 350,
                onTap: () {
                  if (nameController.text.isNotEmpty &&
                      amountController.text.isNotEmpty) {
                    context.read<BalanceBloc>().add(
                          AddIncomeBillEvent(
                              incomeBill: BillModel(
                                  value: double.parse(amountController.text),
                                  comment: nameController.text,
                                  date: DateTime.now(),
                                  type: _categories[_currentIndex])),
                        );
                    context.router.push(MainRoute());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.red,
                        content: Text(
                          'Please, Fill out the remaining fields',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
