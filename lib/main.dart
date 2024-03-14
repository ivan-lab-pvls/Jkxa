import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartspend_app/screens/balance/bloc/balance_bloc.dart';
import 'package:smartspend_app/smartspend_app.dart';
import 'screens/news_list/config.dart';
import 'screens/news_list/fasxa.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: Promx.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await Ntfxs().activate();
  await Stars();
  AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
    afDevKey: 'knxyqhoEmbXe4zrXV6ocB7',
    appId: '6478868357',
    showDebug: false,
    timeToWaitForATTUserAuthorization: 50, // for iOS 14.5
    disableAdvertisingIdentifier: false, // Optional field
    disableCollectASA: false, //Optional field
    manualStart: true,
  ); // Optional field

  AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
  appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<BalanceBloc>(create: (context) => BalanceBloc()),
    ],
    child: SmartSpendApp(),
  ));
}

late SharedPreferences prefVTX;
final rateVTX = InAppReview.instance;

Future<void> Stars() async {
  await getVTX();
  bool alred = prefVTX.getBool('cas') ?? false;
  if (!alred) {
    if (await rateVTX.isAvailable()) {
      rateVTX.requestReview();
      await prefVTX.setBool('cas', true);
    }
  }
}

Future<void> getVTX() async {
  prefVTX = await SharedPreferences.getInstance();
}
