String dateToString(DateTime d){

  int year = d.year;
  int month = d.month;
  int day = d.day;

  return '$year-$month-$day';

}

String dateToInvertedString(DateTime d){

  int year = d.year;
  int month = d.month;
  int day = d.day;

  if(day < 10 && month < 10)
    return '0$day-0$month-$year';
  else if(day < 10)
    return '0$day-$month-$year';
  else if(month < 10)
    return '$day-0$month-$year';
  else
    return '$day-$month-$year';

}

String timeToString(DateTime d){

  int hour = d.hour;
  int minutes = d.minute;
  if(hour < 10 && minutes < 10){
    return '0$hour:0$minutes';
  }
  else if(hour < 10){
    return '0$hour:$minutes';
  }
  else if(minutes < 10){
    return '$hour:0$minutes';
  }
  else
    return '$hour:$minutes';

}

String dateAndTimeToString(DateTime d){

  int year = d.year;
  int month = d.month;
  int day = d.day;
  int hour = d.hour;
  int minutes = d.minute;

  return '$day-$month-$year $hour:$minutes';
}