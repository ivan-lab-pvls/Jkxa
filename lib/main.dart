import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartspend_app/screens/balance/bloc/balance_bloc.dart';
import 'package:smartspend_app/smartspend_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<BalanceBloc>(
          create: (context) => BalanceBloc()),
    ],
    child: SmartSpendApp(),
  ));

}

