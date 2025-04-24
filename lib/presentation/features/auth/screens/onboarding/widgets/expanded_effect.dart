
import '../models/indicator_effect.dart';

class ExpandingDotsEffect extends IndicatorEffect {
  final double expansionFactor;

  ExpandingDotsEffect({
    required super.activeDotColor,
    required super.dotColor,
    required super.dotHeight,
    required super.dotWidth,
    required this.expansionFactor,
    required super.spacing,
  });
}
