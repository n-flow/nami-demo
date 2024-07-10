// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_attend/app/utils/logger.dart';

enum DateFormats {
  FORMAT_1("yyyy-MM-dd HH:mm:ss"),
  FORMAT_2("yyyy-MM-dd HH:mm"),
  FORMAT_3("yyyyMMdd-HHmmss"),
  FORMAT_4("yyyy-MM-dd"),
  FORMAT_5("MM-dd"),
  FORMAT_6("HH:mm:ss"),
  FORMAT_7("HH:mm"),
  FORMAT_8("yyyy-MM"),
  FORMAT_9("yyyy/MM/dd HH:mm:ss"),
  FORMAT_10("HH:mm a"),
  FORMAT_11("EEE, d MMM yyyy"),
  FORMAT_12("EEE-ddMMMyyyy"),
  FORMAT_13("MM/dd/yyyy"),
  FORMAT_14("d MMM, yyyy"),
  FORMAT_15("dd-MM-yyyy"),
  FORMAT_16("yyyy/MM/dd"),
  FORMAT_17("yyyy-MM-dd"),
  FORMAT_18("dd/MM/yyyy"),
  FORMAT_19("hh:mm a"),
  FORMAT_20("hh:mm aa"),
  FORMAT_21("dd, MMM yyyy"),
  FORMAT_22("dd MMM yyyy"),
  FORMAT_23("dd MMM, yyyy hh:mm aa"),
  FORMAT_24("dd, MMM"),
  FORMAT_25("E, dd MMM"),
  FORMAT_26("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),
  FORMAT_27("MMMM"),
  FORMAT_28("dd"),
  FORMAT_29("yyyy-MM-dd'T'HH:mm:ss.000000"),
  FORMAT_30("MMMM dd, yyyy"),
  FORMAT_31("MMM dd"),
  FORMAT_32("dd MMM, hh:mm aa"),
  FORMAT_33("yyyy-MM-dd'T'HH:mm:ss.SSS'GMT'"),
  FORMAT_34("dd/MMM/yyyy"),
  FORMAT_35("MMM dd, yyyy"),
  FORMAT_36("yyyy"),
  FORMAT_37("yyyyMMddHHmmss"),
  FORMAT_38("dd-MM-yyyy'T'HH:mm:ss.SSS'Z'"),
  FORMAT_39("dd MMM yyyy"),
  FORMAT_40("EEEE"),
  ;

  const DateFormats(this.format);

  final String format;
}

DateTime? getNullDateTimeFromString(String? date) {
  if (date == null) {
    return null;
  }
  try {
    return DateTime.parse(date);
  } catch (e) {
    return null;
  }
}

DateTime getDateTimeFromString(String? date, {String? pattern}) {
  if (date == null) {
    return DateTime.now();
  }
  try {
    return DateFormat(pattern).parse(date);
  } catch (e) {
    Log.i("GetDateTimeFromString:  ${e.toString()}");
    return DateTime.now();
  }
}

DateTime getDateTimeFromMillisecondsSinceEpoch(int? millisecondsSinceEpoch) {
  try {
    return DateTime.fromMillisecondsSinceEpoch(
        millisecondsSinceEpoch ?? getDateTime());
  } catch (e) {
    return DateTime.now();
  }
}

String getDateFormatFromDate(
    {String? pattern, DateTime? dateTime, String? local}) {
  // initializeDateFormatting();
  String? languageCode = local;
  if (languageCode == null && Get.context != null) {
    languageCode = Localizations.localeOf(Get.context!).languageCode;
  }
  languageCode ??= const Locale.fromSubtags().languageCode;
  return DateFormat(pattern ?? DateFormats.FORMAT_37.format /*, languageCode*/)
      .format(dateTime ?? DateTime.now());
}

int getDateTime() => DateTime.now().millisecondsSinceEpoch;

int getDateTimeFromDate(String toDate, {String? pattern}) {
  return getDateTimeFromString(toDate, pattern: pattern).millisecondsSinceEpoch;
}

int getSpecificDateTime(
    {int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond}) {
  var today = DateTime.now();
  var date = DateTime(
      year ?? today.year,
      month ?? today.month,
      day ?? today.day,
      hour ?? today.hour,
      minute ?? today.minute,
      second ?? today.second,
      millisecond ?? today.millisecond);

  return date.millisecondsSinceEpoch;
}
