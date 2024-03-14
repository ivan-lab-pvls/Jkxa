import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartspend_app/router/router.dart';
import 'package:smartspend_app/screens/main/main_screen.dart';
import 'package:smartspend_app/screens/onboarding/widgets/onboarding_card_widget.dart';
import 'package:smartspend_app/theme/colors.dart';
import 'package:smartspend_app/widgets/action_button_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.blue,
                    dotColor: AppColors.fontGrey,
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
                SizedBox(
                  height: 350,
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        isLastPage = index == 2;
                      });
                    },
                    controller: controller,
                    children: const [
                      OnboardingCardWidget(
                          title: 'Welcome to the GAX Invest',
                          urlImage: 'assets/images/onboarding/1.png'),
                      OnboardingCardWidget(
                          title: 'Manage your finances with confidence',
                          urlImage: 'assets/images/onboarding/2.png'),
                      OnboardingCardWidget(
                          title:
                              'Calculate your investments with our convenient app',
                          urlImage: 'assets/images/onboarding/3.png'),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Align(
                  alignment: Alignment.center,
                  child: ActionButtonWidget(
                    text: isLastPage ? 'Get Started' : 'Next',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const MainScreen()));
                    },
                    width: 370,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
