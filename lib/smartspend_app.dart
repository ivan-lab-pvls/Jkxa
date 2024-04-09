import 'dart:convert';
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
  timeToWaitForATTUserAuthorization: 50,
  disableAdvertisingIdentifier: true,
  disableCollectASA: true,
);
AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
String campaignx = '';
String campaignID = '';

class DeepLink {
  DeepLink(this._clickEvent);
  final Map<String, dynamic> _clickEvent;
  Map<String, dynamic> get clickEvent => _clickEvent;
  String? get deepLinkValue => _clickEvent["deep_link_value"] as String;
  String? get matchType => _clickEvent["match_type"] as String;
  String? get clickHttpReferrer => _clickEvent["click_http_referrer"] as String;
  String? get mediaSource => _clickEvent["media_source"] as String;
  String? get campaign => _clickEvent["campaign"] as String;
  String? get campaignId => _clickEvent["campaign_id"] as String;
  String? get afSub1 => _clickEvent["af_sub1"] as String;
  String? get afSub2 => _clickEvent["af_sub2"] as String;
  String? get afSub3 => _clickEvent["af_sub3"] as String;
  String? get afSub4 => _clickEvent["af_sub4"] as String;
  String? get afSub5 => _clickEvent["af_sub5"] as String;
  bool get isDeferred => _clickEvent["is_deferred"] as bool;

  @override
  String toString() {
    return 'DeepLink: ${jsonEncode(_clickEvent)}';
  }

  String createParams() {
    if (campaign != null) {
      campaignx = 'campaign=$campaign';
    } else {
      campaignx = 'test';
    }
    if (campaignId != null) {
      campaignID = 'campaignId=$campaignId';
    } else {
      campaignID = 'test2';
    }
    return '&$campaignx&$campaignID';
  }
}

late DeepLink deepLink;

class _SmartSpendAppState extends State<SmartSpendApp> {
  String promo = '';
  String afStatus = '';
  String urlParameters = '';
  String campaignId = '';
  String isFirstLaunch = '';

  Map<String, dynamic>? payload;
  Map<String, dynamic>? atttributionPayload;
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
    AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
      afDevKey: "knxyqhoEmbXe4zrXV6ocB7",
      appId: "6478868357",
      showDebug: true,
      timeToWaitForATTUserAuthorization: 50,
      disableAdvertisingIdentifier: true,
      disableCollectASA: true,
    );
    AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

    await appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );
    appsflyerSdk.startSDK();
    appsflyerSdk.onInstallConversionData((data) {
      payload = data['payload'];
      afStatus = payload!['af_status'] ?? '';
      isFirstLaunch = payload!['is_first_launch'] ?? 'false';
      setState(() {
        urlParameters = '&is_first_launch=$isFirstLaunch&af_status=$afStatus';
      });
      deepLink = DeepLink(data);
      postbacks = deepLink.createParams();
    });

    appsflyerSdk.onAppOpenAttribution((data) {
      print("App Open Attribution:");
      data.forEach((key, value) {
        print("$key: $value");
      });
    });

    appsflyerSdk?.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          print(dp.deepLink?.toString());
          print("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          print("deep link not found");
          break;
        case Status.ERROR:
          print("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          print("deep link status parsing error");
          break;
      }
    });
  }

  String postbacks = '';

  Future<bool> checkPromotions() async {
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
        String dataFor = value;

        try {
          dataFor = remoteConfig
              .getString(campaignId.isNotEmpty ? campaignId : 'promotion');
          if (dataFor != value && dataFor.contains('http')) {
            appsflyerSdk.logEvent("opened", {
              "lnk": '$dataFor$urlParameters',
            });
            return true;
          }
        } catch (e) {
          promo =
              '$dataFor&is_first_launch=$isFirstLaunch&af_status=$afStatus$postbacks';
          return true;
        }
        promo =
            '$dataFor&is_first_launch=$isFirstLaunch&af_status=$afStatus$postbacks';
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
