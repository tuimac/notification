import 'dart:io';
import 'package:frontend/models/logs.dart';
import 'package:frontend/services/logService.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class FilePath {
  static Future<String> get baseDir {
    try {
      if (Platform.isAndroid) {
        return getApplicationDocumentsDirectory().then((directory) {
          return directory.path;
        });
      } else {
        return getLibraryDirectory().then((directory) {
          return directory.path;
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> logPath() async {
    try {
      final directory = join(await baseDir, 'logs');
      final path = join(directory, 'latest.log');
      if (!await Directory(directory).exists()) {
        Directory(directory).create(recursive: true);
      }
      return path;
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }

  static Future<String> passcodePath() async {
    try {
      final directory = join(await baseDir, 'passcode');
      final path = join(directory, 'passcode');
      if (!await Directory(directory).exists()) {
        Directory(directory).create(recursive: true);
      }
      return path;
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }

  static Future<String> dataPath() async {
    try {
      final directory = join(await baseDir, 'data');
      final path = join(directory, 'latest.json');
      if (!await Directory(directory).exists()) {
        Directory(directory).create(recursive: true);
      }
      return path;
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }

  static Future<String> configPath() async {
    try {
      final directory = join(await baseDir, 'config');
      final path = join(directory, 'config.json');
      if (!await Directory(directory).exists()) {
        Directory(directory).create(recursive: true);
      }
      return path;
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }
}
