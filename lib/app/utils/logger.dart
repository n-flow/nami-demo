import 'package:logger/logger.dart';

class Log {
  static final _printStyle = PrettyPrinter(
      methodCount: 1,
      colors: false,
      printTime: false,
      printEmojis: false,
      excludePaths: [
        "package:smart_attend/app/utils/logger.dart",
        "dart:async",
        "package:get",
        "package:flutter",
      ]);

  static void v(dynamic message,
      {dynamic error, StackTrace? stackTrace, LogPrinter? printer}) {
    printLong(message,
        printer: printer ?? _printStyle,
        error: error,
        stackTrace: stackTrace,
        level: Level.trace);
  }

  /// Log a message at level [Level.debug].
  static void d(dynamic message,
      {dynamic error, StackTrace? stackTrace, LogPrinter? printer}) {
    printLong(message,
        printer: printer ?? _printStyle,
        error: error,
        stackTrace: stackTrace,
        level: Level.debug);
  }

  /// Log a message at level [Level.info].
  static void i(dynamic message,
      {dynamic error, StackTrace? stackTrace, LogPrinter? printer}) {
    printLong(message,
        printer: printer ?? _printStyle,
        error: error,
        stackTrace: stackTrace,
        level: Level.info);
  }

  /// Log a message at level [Level.warning].
  static void w(dynamic message,
      {dynamic error, StackTrace? stackTrace, LogPrinter? printer}) {
    printLong(message,
        printer: printer ?? _printStyle,
        error: error,
        stackTrace: stackTrace,
        level: Level.warning);
  }

  /// Log a message at level [Level.error].
  static void e(dynamic message,
      {dynamic error, StackTrace? stackTrace, LogPrinter? printer}) {
    printLong(message,
        printer: printer ?? _printStyle,
        error: error,
        stackTrace: stackTrace,
        level: Level.error);
  }

  /// Log a message at level [Level.f].
  static void f(dynamic message,
      {dynamic error, StackTrace? stackTrace, LogPrinter? printer}) {
    printLong(message,
        printer: printer ?? _printStyle,
        error: error,
        stackTrace: stackTrace,
        level: Level.fatal);
  }

  static void printLong(dynamic message,
      {Level? level,
      dynamic error,
      StackTrace? stackTrace,
      LogPrinter? printer}) {
    // if (!kReleaseMode) {
    var msg = "";
    if (message.toString().length > 800) {
      final pattern = RegExp('.{1,800}');
      pattern.allMatches(message).forEach((match) {
        msg += match.group(0) ?? "";
        msg += "\n";
      });
    } else {
      msg = message ?? "";
    }
    Logger(printer: printer)
        .log(level ?? Level.trace, msg, stackTrace: stackTrace, error: error);
    // }
  }
}
