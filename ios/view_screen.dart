import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PreviewScreen extends StatelessWidget {
  final String dataForPage;

  const PreviewScreen({Key? key, required this.dataForPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(dataForPage)),
        ),
      ),
    );
  }
}

class PreviewwScreen extends StatelessWidget {
  final String dataForPage;

  const PreviewwScreen({Key? key, required this.dataForPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(dataForPage)),
        ),
      ),
    );
  }
}
