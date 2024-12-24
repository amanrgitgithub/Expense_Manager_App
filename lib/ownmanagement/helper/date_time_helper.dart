// convert a datetime object to a stirng yy mm dd
class DateTimeUtils {
  String convertDateTimeToString(DateTime dateTime) {
    // year in the format -> yyy
    String year = dateTime.year.toString();

    // / month in the format -> mmm
    String month = dateTime.month.toString().padLeft(2, '0');

    //  day in the format -> ddd
    String day = dateTime.day.toString().padLeft(2, '0');

    // final formaat -> yymmdd
    // String yyyymmdd = year + month + day;

    // Hour in the format -> HH
    String hour = dateTime.hour.toString().padLeft(2, '0');

    // Minute in the format -> mm
    String minute = dateTime.minute.toString().padLeft(2, '0');

    // return '$yyy-$mm-$dd';
    return '$day-$month-$year $hour:$minute';
  }
}
