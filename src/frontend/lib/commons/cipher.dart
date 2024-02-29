import 'package:encrypt/encrypt.dart';
import 'package:frontend/models/logs.dart';
import 'package:frontend/services/logService.dart';
import 'package:frontend/services/passcodeService.dart';

class Cipher {
  static Future<String> encryptData(String data, {String password = ''}) async {
    try {
      return await PasscodeService.getPasscode().then((passCode) {
        if (password == '') {
          final encrypter =
              Encrypter(AES(Key.fromUtf8(passCode), mode: AESMode.ecb));
          return encrypter.encrypt(data).base64;
        } else {
          while (password.length < 32) {
            password += password;
          }
          final encrypter =
              Encrypter(AES(Key.fromUtf8(password), mode: AESMode.ecb));
          return encrypter.encrypt(data).base64;
        }
      });
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }

  static Future<String> decryptData(String data, {String password = ''}) async {
    try {
      return await PasscodeService.getPasscode().then((passCode) {
        if (password == '') {
          final encrypter =
              Encrypter(AES(Key.fromUtf8(passCode), mode: AESMode.ecb));
          return encrypter.decrypt(Encrypted.fromBase64(data));
        } else {
          while (password.length < 32) {
            password += password;
          }
          final encrypter =
              Encrypter(AES(Key.fromUtf8(password), mode: AESMode.ecb));
          return encrypter.decrypt(Encrypted.fromBase64(data));
        }
      });
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }
}
