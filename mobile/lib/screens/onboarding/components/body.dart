import 'package:easy_read/screens/welcome_screen.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/models/feature_info.dart';
import 'package:easy_read/shared/util/my_primary_button.dart';
import 'package:easy_read/screens/onboarding/components/feature.dart';

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
                MyPrimaryButton(
                  text: 'Skip',
                  press: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    );
                  },
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
      duration: myAnimationDuration,
      height: myDefaultSize * 1.1,
      width: myDefaultSize * 1.1,
      decoration: BoxDecoration(
        color: currentPage == index
            ? mySecondaryColor
            : mySecondaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(myDefaultSize * 0.8),
      ),
      margin: const EdgeInsets.only(right: myDefaultSize),
    );
  }
}
