import 'package:flutter/material.dart';

const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFFFFFFF),
  100: Color(0xFFFFFFFF),
  200: Color(0xFFFFFFFF),
  300: Color(0xFFFFFFFF),
  400: Color(0xFFFFFFFF),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
  800: Color(0xFFFFFFFF),
  900: Color(0xFFFFFFFF),
});
const int _primaryPrimaryValue = 0xFFFFFFFF;

const MaterialColor primaryAccent = MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_primaryAccentValue),
  400: Color(0xFFFFFFFF),
  700: Color(0xFFFFFFFF),
});
const int _primaryAccentValue = 0xFFFFFFFF;