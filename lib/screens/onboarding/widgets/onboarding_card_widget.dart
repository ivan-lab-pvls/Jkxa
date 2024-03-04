import 'package:flutter/material.dart';
import 'package:smartspend_app/theme/colors.dart';

class OnboardingCardWidget extends StatelessWidget {
  final String title;
  final String urlImage;

  const OnboardingCardWidget(
      {super.key,
        required this.title,
        required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(urlImage),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}