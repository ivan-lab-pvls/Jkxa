import 'package:flutter/material.dart';
import 'package:smartspend_app/router/router.dart';

class SmartSpendApp extends StatelessWidget {
  SmartSpendApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Roboto'),
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
