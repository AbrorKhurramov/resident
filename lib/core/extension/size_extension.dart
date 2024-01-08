
import 'package:flutter/material.dart';

extension SizeExtension on int {


  double sf(BuildContext context) {
    return this/(MediaQuery.of(context).textScaleFactor);
  }

}