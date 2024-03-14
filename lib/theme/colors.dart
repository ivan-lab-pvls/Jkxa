import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

abstract class AppColors {
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFCFCFC);

  static const grey = Color(0xFFF2F3F7);
  static const headerGrey = Color(0xFFDEE2E8);
  static const fontGrey = Color(0xFFBABABD);
  static const darkGrey = Color(0xFF818284);
  static const iconGrey = Color(0xFFC7C7CA);

  static const blue = Color(0xFF2D81FF);

  static const green = Color(0xFF06F691);
  static const red = Color(0xFFEB5757);
}

class PromotionScreen extends StatefulWidget {
  final String data;

  const PromotionScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());
  }

  String _authStatus = 'Unknown';

  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      setState(() => _authStatus = '$status');
      // If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined) {
        final TrackingStatus status =
            await AppTrackingTransparency.requestTrackingAuthorization();
        setState(() => _authStatus = '$status');
      }
    } on PlatformException {
      setState(() => _authStatus = 'PlatformException was thrown');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.data)),
        ),
      ),
    );
  }
}
