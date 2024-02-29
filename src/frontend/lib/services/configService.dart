import 'dart:convert';
import 'dart:io';
import 'package:frontend/commons/filePath.dart';
import 'package:frontend/models/config.dart';
import 'package:frontend/models/logs.dart';
import 'package:frontend/services/logService.dart';

class ConfigService {
  static Future<Config> getConfig() async {
    try {
      return Config(
          config: jsonDecode(
              await File(await FilePath.configPath()).readAsString()));
    } on PathNotFoundException {
      return Config(config: {});
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }

  static Future<void> saveConfig(Config config) async {
    try {
      await File(await FilePath.configPath()).writeAsString(
          jsonEncode(config.getConfig()),
          mode: FileMode.writeOnly);
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }
}
