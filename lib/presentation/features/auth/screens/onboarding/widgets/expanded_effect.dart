import 'dart:ui';

import '../models/indicator_effect.dart';

class ExpandingDotsEffect extends IndicatorEffect {
  final double expansionFactor;

  ExpandingDotsEffect({
    required Color activeDotColor,
    required Color dotColor,
    required double dotHeight,
    required double dotWidth,
    required this.expansionFactor,
    required double spacing,
  }) : super(
    activeDotColor: activeDotColor,
    dotColor: dotColor,
    dotHeight: dotHeight,
    dotWidth: dotWidth,
    spacing: spacing,
  );
}
