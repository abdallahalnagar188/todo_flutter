import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeUtils on DateTime {
  int dateOnly() {
    var newDateTime = DateTime(year, month, day);
    return newDateTime.microsecondsSinceEpoch;
  }

  String formatDate() {
    final DateFormat format = DateFormat('yyyy/MM/dd');
    return format.format(DateTime(year, month, day));
  }
}

extension TimeUtils on TimeOfDay {
  int timeOnly() {
    var newDateTime = DateTime(0, 0, 0, hour, minute);
    return newDateTime.microsecondsSinceEpoch;
  }

  String formatTime() {
    final DateFormat format = DateFormat('HH:mm a');
    return format.format(DateTime(0, 0, 0, hour, minute));
  }
}

extension TimeFormats on int {
  String formatTime() {
    final DateFormat format = DateFormat('HH:mm a');
    return format.format(DateTime.fromMicrosecondsSinceEpoch(this));
  }
}
