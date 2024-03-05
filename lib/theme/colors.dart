import 'package:flutter/material.dart';
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

class PromotionScreen extends StatelessWidget {
  final String data;

  const PromotionScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(data)),
        ),
      ),
    );
  }
}