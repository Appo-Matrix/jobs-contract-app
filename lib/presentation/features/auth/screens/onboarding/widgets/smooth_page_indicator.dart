import 'package:flutter/cupertino.dart';

import '../models/indicator_effect.dart';
import 'expanded_effect.dart';

class SmoothPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;
  final IndicatorEffect effect;

  const SmoothPageIndicator({super.key, 
    required this.controller,
    required this.count,
    required this.effect,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        double page = controller.hasClients
            ? controller.page ?? controller.initialPage.toDouble()
            : controller.initialPage.toDouble();

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            count,
                (index) {
              double distance = (page - index).abs();
              bool isActive = distance < 0.5;

              // Calculate dot width based on distance from current page
              double width = 0;
              if (effect is ExpandingDotsEffect) {
                // Increase width for unselected tabs too
                if (isActive) {
                  width = effect.dotWidth * effect.spacing;
                } else {
                  // Set wider base width for unselected dots (15 instead of 10)
                  width = 15;

                  if (distance < 1) {
                    // Interpolate width for smooth transition
                    width = 15 + (effect.spacing * effect.dotWidth - 15) * (1 - distance);
                  }
                }
              } else {
                width = isActive ? effect.dotWidth * 2 : effect.dotWidth;
              }

              return Container(
                margin: EdgeInsets.symmetric(horizontal: effect.spacing / 2),
                width: width,
                height: effect.dotHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(effect.dotHeight / 2),
                  color: isActive ? effect.activeDotColor : effect.dotColor,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
