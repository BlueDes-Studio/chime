import 'package:chime/config/colorscheme.dart';
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
    return lightGreen;
  }
  if (percentage <= 75 && percentage > 50) {
    return lightYellow;
  }
  return lightRed;
}

double recommendNumberOfClassesToAttend(int attended, int total, int target) {
  return ((target * total) - (100 * attended)) / (100 - target);
}
