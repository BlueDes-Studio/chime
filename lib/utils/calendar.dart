// ignore_for_file: non_constant_identifier_names

String convertIntToWeekDay(int i) {
  switch (i) {
    case 0:
      return "Sun";
    case 1:
      return "Mon";
    case 2:
      return "Tue";
    case 3:
      return "Wed";
    case 4:
      return "Thu";
    case 5:
      return "Fri";
    case 6:
      return "Sat";
    default:
      return "Sat";
  }
}

String getCurrMonth_MonthYYYY() {
  DateTime now = DateTime.now();
  String parseDate = "";
  switch (now.month) {
    case DateTime.january:
      parseDate += "Jan";
      break;
    case DateTime.february:
      parseDate += "Feb";
      break;
    case DateTime.march:
      parseDate += "Mar";
      break;
    case DateTime.april:
      parseDate += "April";
      break;
    case DateTime.may:
      parseDate += "May";
      break;
    case DateTime.june:
      parseDate += "June";
      break;
    case DateTime.july:
      parseDate += "July";
      break;
    case DateTime.august:
      parseDate += "Aug";
      break;
    case DateTime.september:
      parseDate += "Sep";
      break;
    case DateTime.october:
      parseDate += "Oct";
      break;
    case DateTime.november:
      parseDate += "Nov";
      break;
    case DateTime.december:
      parseDate += "Dec";
      break;
  }

  return "$parseDate ${now.year}";
}

class DateValueReturned {
  String val;
  bool currMonth;
  DateValueReturned({required this.val, required this.currMonth});
}

List<DateValueReturned> genDateArray_forMonth(int month) {
  DateTime now = DateTime.now();
  DateTime firstDay = DateTime(now.year, month, 1);
  List<DateValueReturned> returnDates = [];

  for (int i = DateTime(now.year, now.month, 0).day - firstDay.weekday + 1;
      i < DateTime(now.year, now.month, 0).day + 1;
      i++) {
    returnDates.add(DateValueReturned(val: "$i", currMonth: false));
  }

  int counter = 1;
  for (int i = 1; i < DateTime(now.year, now.month + 1, 0).day + 2; i++) {
    returnDates.add(DateValueReturned(val: "$counter", currMonth: true));
    counter++;
  }

  int nextCounter = 1;
  for (int i = counter + firstDay.weekday - 1; i < 35; i++) {
    returnDates.add(DateValueReturned(val: "$nextCounter", currMonth: false));
    nextCounter++;
  }

  return returnDates;
}
