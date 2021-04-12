import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

class Dimension {
  static double height = 0.0;
  static double witdh = 0.0;

  static double getWidth(double size) {
    return witdh * size;
  }

  static double getHeight(double size) {
    return height * size;
  }
}

class Utils {
  static String getExtension(String path) {
    return p.extension(path);
  }

  static String getNameFile(String path) {
    return p.basename(path);
  }

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
}

class ChangeTime {
  static String ChangeTimeStampToTime(
      double timestamp, bool isHasHour, bool isJustyear, bool isJustHour) {
    if (isHasHour == true && isJustyear == false && isJustHour == false) {
      var format = new DateFormat("dd/MM/yyyy HH:mm");
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch((timestamp * 1000.0).toInt());
      return format.format(dateTime).toString();
    } else if (isHasHour == false &&
        isJustyear == false &&
        isJustHour == false) {
      var format = new DateFormat("dd/MM/yyyy");
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch((timestamp * 1000.0).toInt());
      return format.format(dateTime).toString();
    } else if (isHasHour == false &&
        isJustyear == true &&
        isJustHour == false) {
      var format = new DateFormat("yyyy");
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch((timestamp * 1000.0).toInt());
      return format.format(dateTime).toString();
    } else if (isHasHour == false &&
        isJustyear == false &&
        isJustHour == true) {
      var format = new DateFormat("HH:mm");
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch((timestamp * 1000.0).toInt());
      return format.format(dateTime).toString();
    } else {
      return "";
    }
  }
}
