import 'package:flutter/material.dart';

import 'colors.dart';

class ThemeGradient {
  static const Color brandPrimary = Color(0xFF7F56D9);  // Primary brand color
  static const Color brandSecondary = Color(0xFF6941C6); // Secondary brand color
  static const Color brandAccent = Color(0xFF53389E);    // Accent color for the brand
  static const Color brandBlack = Color(0xFF000000);
  // Define brand gradients with specified angles
  static const LinearGradient gradient1 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      brandPrimary,
      brandPrimary,
      brandBlack,
      brandSecondary,
    ],
    stops: [0.0, 0.5, 0.75, 1.0], // Control the gradient stops
  );

  static const LinearGradient gradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      brandPrimary,
      brandSecondary,
    ],
    stops: [0.0, 1.0],
  );

  static const LinearGradient gradient3 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      brandPrimary,
      brandAccent,
      brandSecondary,
    ],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient gradient4 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      brandPrimary,
      brandSecondary,
      brandAccent,
    ],
    stops: [0.0, 0.7, 1.0],
  );

  static const LinearGradient gradient5 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      brandPrimary,
      brandBlack,
      brandSecondary,
    ],
    stops: [0.0, 0.6, 1.0],
  );


  // Gradient 01
  static const LinearGradient gradient01 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFA5C0EE),  // #A5C0EE
      Color(0xFFFBC2EB),  // #FBC2EB
      Color(0xFFFFD1FF),  // #FFD1FF
    ],
    stops: [0.0, 0.5, 1.0], // Control the transition
    tileMode: TileMode.clamp,
  );

  // Gradient 02
  static const LinearGradient gradient02 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFD1FF),  // #FFD1FF
      Color(0xFFFBF0C4),  // #FAD0C4
      Color(0xFFFF9A9E),  // #FF9A9E
    ],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );

  // Gradient 03
  static const LinearGradient gradient03 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFCB69F),  // #FCB69F
      Color(0xFFFECFEF),  // #FECFEF
      Color(0xFFFF9DE4),  // #FF9DE4
    ],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );

  // Gradient 04
  static const LinearGradient gradient04 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF9DE4),  // #FF9DE4
      Color(0xFFB7A0C9),  // #A18CD1
      Color(0xFFFAD0C4),  // #FAD0C4
    ],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );

  // Gradient 05
  static const LinearGradient gradient05 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFECD2),  // #FFECD2
      Color(0xFFFF989C),  // #FF989C
      Color(0xFFFFEAFC),  // #FFEAF6
    ],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );

  // Gradient 06
  static const LinearGradient gradient06 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFA5C0EE),  // #A5C0EE
      Color(0xFFFBC5EC),  // #FBC5EC
      Color(0xFFFAD0C4),  // #FAD0C4
    ],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );


  // Mesh Gradient 01 (90 degrees)
  static const LinearGradient meshGradient01 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFA5C0EE),  // #A5C0EE
      Color(0xFFFBC2EB),  // #FBC2EB
      Color(0xFFFFD1FF),  // #FFD1FF
    ],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );

  // Mesh Gradient 02 (90 degrees)
  static const LinearGradient meshGradient02 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFD1FF),  // #FFD1FF
      Color(0xFFFBF0C4),  // #FAD0C4
      Color(0xFFFF9A9E),  // #FF9A9E
    ],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );

  // Mesh Gradient 03 (45 degrees)
  static const LinearGradient meshGradient03 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFCB69F),  // #FCB69F
      Color(0xFFFECFEF),  // #FECFEF
      Color(0xFFFF9DE4),  // #FF9DE4
    ],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );

  // Mesh Gradient 04 (45 degrees)
  static const LinearGradient meshGradient04 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFF9DE4),  // #FF9DE4
      Color(0xFFB7A0C9),  // #A18CD1
      Color(0xFFFAD0C4),  // #FAD0C4
    ],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );

  // Mesh Gradient 05 (90 degrees)
  static const LinearGradient meshGradient05 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFECD2),  // #FFECD2
      Color(0xFFFF989C),  // #FF989C
      Color(0xFFFFEAFC),  // #FFEAF6
    ],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );

  // Mesh Gradient 06 (26.5 degrees)
  static const LinearGradient meshGradient06 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFA5C0EE),  // #A5C0EE
      Color(0xFFFBC5EC),  // #FBC5EC
      Color(0xFFFAD0C4),  // #FAD0C4
    ],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );

  // Mesh Gradient 07 (45 degrees)
  static const LinearGradient meshGradient07 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFD1FF),  // #FFD1FF
      Color(0xFFFBF0C4),  // #FAD0C4
      Color(0xFFFF9A9E),  // #FF9A9E
    ],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );

}