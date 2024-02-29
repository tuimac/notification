import 'dart:io';
import 'dart:math';
import 'package:frontend/commons/filePath.dart';
import 'package:frontend/models/logs.dart';
import 'package:frontend/services/logService.dart';

class PasscodeService {
  static Future<String> getPasscode() async {
    try {
      return await File(await FilePath.passcodePath()).readAsString();
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }

  static Future<void> registerPasscode() async {
    try {
      const charset =
          '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
      final random = Random.secure();
      final passcode =
          List.generate(32, (_) => charset[random.nextInt(charset.length)])
              .join();
      await File(await FilePath.passcodePath())
          .writeAsString(passcode, mode: FileMode.writeOnly);
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }
}
