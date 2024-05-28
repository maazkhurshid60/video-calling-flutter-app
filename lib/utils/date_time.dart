

import 'package:flutter/material.dart';

String convertStringToTime(String time) {
  final int timeInInt = int.tryParse(time) ?? 0000000000000;

  final dateTimeFromMilliseconds = DateTime.fromMillisecondsSinceEpoch(timeInInt, isUtc: true).toLocal();

  final timeOfDay = TimeOfDay(hour: dateTimeFromMilliseconds.hour, minute: dateTimeFromMilliseconds.minute);

  final finalTime = '${timeOfDay.hour}:${timeOfDay.minute} ${timeOfDay.period.name}';

  return finalTime.toUpperCase();
}