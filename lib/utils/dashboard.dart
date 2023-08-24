import 'package:flutter/material.dart';

enum AttendanceStatus {
  selectPresent,
  unselectPresent,
  selectAbsent,
  unselectAbsent,
  selectCancel,
  unselectCancel,
  expandCard,
}

Color getProgressBarColor(double percentage) {
  if (percentage <= 100 && percentage > 75) {
    return const Color(0xff91EC59);
  }
  if (percentage <= 75 && percentage > 50) {
    return const Color(0xffEFDE47);
  }
  return const Color(0xffEC5959);
}

double recommendNumberOfClassesToAttend(int attended, int total, int target) {
  return ((target * total) - (100 * attended)) / (100 - target);
}
