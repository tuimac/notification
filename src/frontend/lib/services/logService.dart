import 'dart:developer';
import 'dart:io';
import 'package:frontend/commons/filePath.dart';
import 'package:frontend/models/logs.dart';

class LogService {
  static Future<List<Logs>> read() async {
    try {
      List<Logs> logs = [];
      for (String logline in File(await FilePath.logPath()).readAsLinesSync()) {
        logs.add(Logs(logline: logline));
      }
      return logs;
    } catch (e) {
      rethrow;
    }
  }

  static void write(Logs logs) async {
    try {
      log(logs.getMessage());
      await File(await FilePath.logPath())
          .writeAsString(logs.createLog(), mode: FileMode.writeOnlyAppend);
    } catch (e) {
      rethrow;
    }
  }
}
