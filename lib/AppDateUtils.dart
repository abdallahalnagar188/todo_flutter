import 'package:flutter/material.dart';

extension DateTimeUtils on DateTime {
  int dateOnly() {
    var newDateTime = DateTime(year, month, day);
    return newDateTime.microsecondsSinceEpoch;
  }
}

extension TimeUtils on TimeOfDay {
  int timeOnly() {
    var newDateTime = DateTime(0, 0, 0,hour,minute);
    return newDateTime.microsecondsSinceEpoch;
  }
}