import 'dart:ui';

import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  brightness: Brightness.dark,
);

ImageFilter blur = ImageFilter.blur(sigmaX: 4, sigmaY: 4);
