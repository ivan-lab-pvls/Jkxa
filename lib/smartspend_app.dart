import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:smartspend_app/router/router.dart';

import 'screens/onboarding/onboarding_screen.dart';
import 'theme/colors.dart';

class SmartSpendApp extends StatefulWidget {
  SmartSpendApp({super.key});

  @override
  State<SmartSpendApp> createState() => _SmartSpendAppState();
}

AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
          afDevKey: "knxyqhoEmbXe4zrXV6ocB7",
          appId: "6478868357",
          showDebug: true,
          timeToWaitForATTUserAuthorization: 15,
          manualStart: true,
        );

        AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

class _SmartSpendAppState extends State<SmartSpendApp> {
  String promo = '';
  Future<bool> checkPromotions() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    String value = remoteConfig.getString('promotion');
    String exampleValue = remoteConfig.getString('promotionFeed');
    final client = HttpClient();
    var uri = Uri.parse(value);
    var request = await client.getUrl(uri);
    request.followRedirects = false;
    var response = await request.close();
    if (!value.contains('havenot')) {
      if (response.headers.value(HttpHeaders.locationHeader).toString() !=
          exampleValue) {
        AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
          afDevKey: "knxyqhoEmbXe4zrXV6ocB7",
          appId: "6478868357",
          showDebug: true,
          timeToWaitForATTUserAuthorization: 15,
          manualStart: true,
        );

        AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

        // Init of AppsFlyer SDK
        appsflyerSdk.initSdk(
          registerConversionDataCallback: true,
          registerOnAppOpenAttributionCallback: true,
          registerOnDeepLinkingCallback: true,
        );

        appsflyerSdk.startSDK();

        appsflyerSdk.logEvent("CustomEvent", {
          "log": "open",
        });

        promo = value;
        return true;
      }
    }
    return false;
  }

  Future<bool?> logEvent(String eventName, Map? eventValues) async {
    bool? result;
    try {
        result = await appsflyerSdk.logEvent(eventName, eventValues);
    } on Exception catch (e) {}
    print("Result logEvent: $result");
}

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: checkPromotions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              ),
            );
          } else {
            if (snapshot.data == true && promo != '') {
              return PromotionScreen(data: promo);
            } else {
              return const OnboardingScreen();
            }
          }
        },
      ),
    );
  }
}
