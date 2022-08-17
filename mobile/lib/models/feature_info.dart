class FeatureInfo {
  /// Holds information about the features
  FeatureInfo({
    required this.text,
    required this.description,
    required this.image,
  });

  final String text, description, image;
}

List<FeatureInfo> features = [
  FeatureInfo(
    text: "Create your account",
    description: "Quickly create a profile in minutes",
    image: "assets/images/onboarding_user.png",
  ),
  FeatureInfo(
    text: "Choose your preferred books",
    description:
        "Purchase/Download Your Books. Also create a list of your favourite reads.",
    image: "assets/images/onboarding_math.png",
  ),
  FeatureInfo(
    text: "Start studying",
    description:
        "Begin reading your purchase so easily, continue from where you left off.",
    image: "assets/images/onboarding_read.png",
  ),
];
