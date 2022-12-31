abstract class AppConstants {
  // explicitly type the constants to avoid implicit dynamic on possible value changes
  static const String name = 'Fedopia';
  static const String clientName = 'Fedopia';
  static const String title = '$name – Federated Social Network';
  static const String website = 'fedopia.app';
  static const String websiteUrl = 'https://$website';
  static const int animationDurationInMilliseconds = 500;
  static const Duration animationDuration = Duration(
    milliseconds: animationDurationInMilliseconds,
  );
}
