import 'package:flutter/material.dart';

abstract class ETextStyle {

  static const _satoshiRegular = 'Satoshi';

  static const satoshiRegular = TextStyle(
    fontFamily: _satoshiRegular,
    fontWeight: FontWeight.w400,
    fontSize: 19,
    height: 1,
    letterSpacing: 0,
  );
}
