import 'package:flutter/material.dart';

class AppColor {
  static const Color c1000 = Color(0xFF002649);
  static const Color c2000 = Color(0xFF012240);
  static const Color c3000 = Color(0xFF6E717B);
  static const Color c4000 = Color(0xFF080B16);
  static const Color c5000 = Color(0xFF0F1113);
  static const Color c6000 = Color(0xFF3891FA);
  static const Color c7000 = Color(0xFF52B515);
  static const Color c8000 = Color(0xFFCACDD8);
  static const Color c9000 = Color(0xFFA6A9B6);
  static const Color transparent = Color(0x00000000);

  static const Color c10000 = Color(0xFF182FFF);
  static const Color c20000 = Color(0xFFDA4FB0);
  static const Color c30000 = Color(0xFF101B23);
  static const Color c40000 = Color(0xFFE8EAF2);
  static const Color c50000 = Color(0xFFBE1515);
  static const Color c60000 = Color(0xFFF5F5F5);
  static const Color c70000 = Color(0xFFF7992C);
  static const Color c80000 = Color(0xFF9A9A9A);
  static const Color c90000 = Color(0xFF525252);

  static const Color c100000 = Color(0xFF85D447);
  static const Color c200000 = Color(0xFFE84949);
  static const Color c300000 = Color(0xFF74B2FC);



  static defaultCardGradient() {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Colors.white.withOpacity(0),
        Colors.white.withOpacity(1),
      ],
    );
  }

  static newsGradient() {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0, 0.3, 0.3, 1],
      colors: [
        Colors.black.withOpacity(0.8),
        Colors.black.withOpacity(0),
        AppColor.c10000.withOpacity(0),
        AppColor.c20000.withOpacity(0.8),
      ],
    );
  }

  static defaultApartmentGradient() {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: const [0.1, 0.5, 1],
      colors: [
        AppColor.c5000.withOpacity(0.8),
        AppColor.c5000.withOpacity(0.4),
        AppColor.c5000.withOpacity(0.1),
      ],
    );
  }

  static loanApartmentGradient() {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: const [0.1, 0.7, 1],
      colors: [
        AppColor.c50000.withOpacity(0.6),
        AppColor.c50000.withOpacity(0.3),
        AppColor.c50000.withOpacity(0.1),
      ],
    );
  }
}
