import 'package:easy_read/screens/home/home_screen.dart';
import 'package:easy_read/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../../model/feature_info.dart';
import 'feature.dart';

class Body extends StatefulWidget {
  /// A walkthrough of the app
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<FeatureInfo> features = [
    FeatureInfo(
      text: "Easy Access to Books",
      description: "Get access to thousands of books from your mobile phone.",
      image: "assets/images/onboarding_book.png",
    ),
    FeatureInfo(
      text: "Massive Sales",
      description: "We sale large quantity of books daily.",
      image: "assets/images/onboarding_shop.png",
    ),
    FeatureInfo(
      text: "Neatly Organised",
      description: "Our books are arranged in different order.",
      image: "assets/images/onboarding_box.png",
    ),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
                onPageChanged: (value) => setState(() => currentPage = value),
                itemCount: features.length,
                itemBuilder: ((BuildContext context, int index) => Feature(
                      text: features[index].text,
                      description: features[index].description,
                      image: features[index].image,
                    ))),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    features.length,
                    (index) => buildDot(index: index),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: miDefaultSize * 4,
                  width: miDefaultSize * 16,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: miLightColor,
                      primary: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: miDefaultSize * 1.1,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(miDefaultSize * 1.4),
                        ),
                      ),
                    ),
                    child: const Text('Skip'),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: miAnimationDuration,
      height: miDefaultSize * 1.1,
      width: miDefaultSize * 1.1,
      decoration: BoxDecoration(
        color: currentPage == index
            ? miPrimaryColor
            : miPrimaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(miDefaultSize * 0.8),
      ),
      margin: const EdgeInsets.only(right: miDefaultSize),
    );
  }
}
