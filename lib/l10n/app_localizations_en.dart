// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Drone License Grade 2';

  @override
  String get quizSubtitle => 'Pass quickly in your spare time! Q&A';

  @override
  String get modeShuffle => 'Shuffle';

  @override
  String get modeSequential => 'In Order';

  @override
  String get lockModeSequential => 'This mode is locked';

  @override
  String get premiumUpgrade => 'Premium Upgrade';

  @override
  String get featureSequentialTitle => 'Unlock \'Sequential\' Mode';

  @override
  String get featureSequentialDesc =>
      'You can solve all questions in order from the first one.';

  @override
  String get featureNoAdsTitle => 'Completely Hide Advertisements';

  @override
  String get featureNoAdsDesc =>
      'All advertisements in the app will be hidden.';

  @override
  String get purchase => 'Purchase';

  @override
  String get cancel => 'Cancel';

  @override
  String reviewWeakness(int count) {
    return 'Review Weakness ($count questions)';
  }

  @override
  String get selectCategory => 'Select Category';

  @override
  String get noData => 'No quiz data available';

  @override
  String get back => 'Undo';

  @override
  String questionNumber(int index) {
    return 'Q$index';
  }

  @override
  String questionsCount(int count) {
    return '$count questions';
  }

  @override
  String get part1 => 'Laws & Rules';

  @override
  String get part2 => 'Aircraft & Systems';

  @override
  String get part3 => 'Flight & Safety';

  @override
  String get part4 => 'Mechanics & Weather';

  @override
  String get premiumCardTitle => 'Upgrade to\nPremium Plan';

  @override
  String get premiumCardSubtitle => 'Focus by hiding ads!';

  @override
  String get restorePurchase => 'Restore Purchase';

  @override
  String get sisterAppPromoTitle => 'Sister App is here!';

  @override
  String get sisterAppPromoSubtitle =>
      'Conquer Drone License Grade 1!\nClick here for details';

  @override
  String get sisterAppDialogTitle => 'Conquer Drone License Grade 1!';

  @override
  String get sisterAppDialogBody =>
      'Opening App Store to take you to the sister app page.';

  @override
  String get open => 'Open';
}
